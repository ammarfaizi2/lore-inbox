Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVAGCDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVAGCDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVAGB77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:59:59 -0500
Received: from [209.195.52.120] ([209.195.52.120]:24306 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261203AbVAGB6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:58:06 -0500
Date: Thu, 6 Jan 2005 17:51:43 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Adrian Bunk <bunk@stusta.de>
cc: Arjan van de Ven <arjan@infradead.org>, Rik van Riel <riel@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050106193510.GL3096@stusta.de>
Message-ID: <Pine.LNX.4.60.0501061737100.12680@dlang.diginsite.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
 <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl>
 <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
 <20050103153438.GF2980@stusta.de> <1104767943.4192.17.camel@laptopd505.fenrus.org>
 <20050104174712.GI3097@stusta.de> <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
 <20050106193510.GL3096@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Adrian Bunk wrote:

>> anyone who assumes that just becouse the kernel is in the stable series
>> they can blindly upgrade their production systems is just dreaming.
>
> I was not thinking about a "blindly upgrade".
>
> But the question is if you compile and test a kernel, is it every
> unlikely or relatively common to observe new problems?
>

in my experiance the answer is very unlikely, and about as likely as I got 
used to during the 2.0, 2.2, and 2.4 series (the 2.4 series had some time 
when it was significantly worse). while I used 1.2 and 0. series kernels 
I didn't follow them well enough to comment on that timeframe.

in every series there have been versions that didn't work, sometimes 
spectacularly, but in every series the later versions tend to fix far more 
then it breaks. I have been burned severely by development series kernels 
and had the same problems as everyone else with the first few 2.0, 2.2, 
and 2.4 series kernels, but I didn't run into the as many problems with 
2.6.0

for those who are concerned about the quality of the 2.6 kernels I'd 
suggest that you don't judge exclusivly by the comments to the list, try 
them yourself.

as far as removing features goes, personally I have a lot of boxes useing 
ipchains instead of iptables, even on 2.6 kernels and will be very unhappy 
if that compatability is removed, but at the same time I'm willing to hold 
off my screaming until Linus actually removes features. the netfilter 
folks can plan all they want to remove the compatability, but they can't 
force Linus to accept the patch that does the removal.

remember that according to some people 2.6.0 wasn't supposed to support 
anything compiled in, everythign was going to be a module, with much of 
the hardware detection removed from the kernel and put into code running 
on initrd or similar.

that didn't happenand I'm willing to lay good odds that removing a feature 
just becouse it's 'old' isn't very likly either. if there are problems 
with a feature and nobody cares about it enough to fix it then the feature 
may be removed, but if it affects a lot of people then it's likly that 
someone will step up to do the maintinance.

if you want another example, look at reiserfs, Hans wants no new 
development done on version 3 becouse version 4 is available and is better 
in all ways. I believe that Hans would like to have version 3 removed and 
replaced with version 4 (with a utility to do the conversion between the 
two), but there are a lot of people who want to keep useing version 3 and 
as a result version 3 is maintained and updated.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
