Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278699AbRJTACc>; Fri, 19 Oct 2001 20:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278700AbRJTACM>; Fri, 19 Oct 2001 20:02:12 -0400
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:24324 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S278699AbRJTACJ>; Fri, 19 Oct 2001 20:02:09 -0400
Message-ID: <3BD0BEB8.2020508@ndsu.nodak.edu>
Date: Fri, 19 Oct 2001 19:00:56 -0500
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011018
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <Pine.LNX.4.40.0110191257070.9276-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> I use this example becouse the question came up a week or so ago and I
> don't remember seeing the issue resolved.


I wish it was easy, but legality/copyright/property rights are not 
always easy topics


> the problem posted is that a BSD no adv licence is GPL compatable and
> source may be available and therefor BSD no adv modules should not taint
> the kernel, on the other hand it's possible to have a BSD no adv licensed
> module that the source is not available for and therefor it should taint
> the kernel.
> 
> just knowing the license doesn't tell you if the source is available
> (which is the stated goal of the taint stuff)


Good point. Anybody else want to chime in here? For linux-kernel's 
purposes at least, a BSD licensed piece of code with no source is about 
as useful as ice-cream to an eskimo. Of course creating BSD licensed 
binaries from closed source is kind of silly. Say we see an external 
module (one not distributed with the kernel source) that identifies 
itself as BSD licensed loaded into somebodies' kernel then ask the 
provider for source and he refuses. Rightfully that kernel should have 
been marked tainted. Is their anything in the licensing that would allow 
us to say that specifying a BSD license in the MODULE_LICENSE tag refers 
to source distribution? Or is that implied?


> if instead of MODULE_LICENSE there was a MODULE_SOURCE tag this would not
> be an issue, and the EXPORT_SYMBOL_GPL would obviously be a seperate
> issue. as it is they both use the MODULE_LICENSE tag which confuses the
> intent of both of them.


What's in a name? If it's called MODULE_LICENSE or MODULE_SOURCE if it's 
defined to mean availability and licensing of module source, that's the 
important distinction. Further, EXPORT_SYMBOL_GPL is a separate issue 
regardless, it allows us a definite way to specify "private" interfaces.

 
> if BSD no adv is considered a non-tainting license then what's to stop all
> the binary-module vendors from useing it in their modules? it doesn't
> requrire that they give the source to anyone so it's no risk to their IP
> but it avaids the 'bad press' of the kernel announcing that useing their
> stuff taints the kernel.


If it becomes public knowledge that a binary-module vendor distributes 
modules marked as BSD licensed but the source is unavailable that would 
be bad PR for them. First they would probably be ignored by 
linux-kernel. They should also be branded as liars for disingenuosly 
marking their products.

 
> on the other hand if BSD no adv is considered a taining license then you
> are going against the statement that it's compatable with the GPL and you
> are telling module programmers who release the source that BSD isn't good
> enough they can only work with the linux kernel if they change to the GPL
> (or one of the other approved licenses)


I don't think anybody wants to disallow linking of GPL compatible code 
with Linux. Given that the FSF thinks that BSD-no-adv is compatible, I'd 
tend to agree with them. If MODULE_LICENSE is to be used as your 
"MODULE_SOURCE" idea is (which I think it is), it's not an issue. As far 
as programmers releasing BSD source, they seem to be OK with it, check 
the source yourself: http://lxr.linux.no/search?string=MODULE_LICENSE.

> again my point is that knowing the license is not enough by itself to know
> if the kernel should be considered tainted, so let's not try to do it this
> way.


Making access control mandatory with source code availability is hard. 
Nobody said this was a be-all, end-all solution, it simply helps screen 
those that would take advantage of people's limited time and effort. It 
depends partly on respect and good-will, so if a vendor wants to violate 
that trust and flaunt arrogance to the folks of the linux community, so 
be it.

> or if the intent really is to force everything to be GPL then just say so
> rather then claiming that that's not your intent.
> 
> David Lang

The intent is to more clearly define the gracious exception that has 
been made for binary-only module vendors. If we decide to disallow the 
use of BSD licensed code (when everybody else in the world can use it) 
that's our loss. In the end we want to respect other people's copyrights 
and have our's respected in turn.

Regards,
Reid

