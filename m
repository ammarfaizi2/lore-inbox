Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbSLETx6>; Thu, 5 Dec 2002 14:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbSLETx6>; Thu, 5 Dec 2002 14:53:58 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:15063
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267411AbSLETxz>; Thu, 5 Dec 2002 14:53:55 -0500
Message-ID: <3DEFB275.9000807@tupshin.com>
Date: Thu, 05 Dec 2002 12:09:25 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: is KERNEL developement finished, yet ??? (ACLs)
References: <200212051224.50317.shanehelms@eircom.net> <000901c29c5d$6d194760$2e833841@joe> <aso4kq$2ka$1@penguin.transmeta.com>
In-Reply-To: <aso4kq$2ka$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Only stupid people think they should throw away old proven concepts. 
> What happens quite often in academia in particular is that you find a
> problem you want to fix, and you re-design the whole system around your
> fix. 
Agreed...
> 
> The UNIX/Linux approach is a very pragmatic thing - leave the things
> that work well alone.  There's no point in re-inventing the whole system
> just because of some small perceived flaws. 
> 
Agreed...
> 
>>This is not a design flaw per say, but let's face it: Unix would be a lot
>>more secure (and more flexible in it's security) with ACL's.
>>
>>Microsoft Windows has had ACL's since 1991 (Windows NT 3.5?); that was 11
>>years ago.
> 
> 
> Yeah, and look how much more secure it is than UNIX.
> 
> 		Linus
An unfortunately inflamatory argument that avoids the real issue.  I'm 
not going to argue the security of NT (heaven forbid), but you do 
completely ignore the benefits of ACLs, including things that 
capabilities don't provide.

The fundamental problem is that while there is a many-to-many 
relationship between users and groups, there is only a one-to-many 
relationship between files and groups. This inequity breeds kludgy 
solutions to problems that would be easy with the many-to-many 
group/file relationships that ACLs provide

A simple example would be four non-root users of a system where user A 
would like to provide read and write access to a file with users B and C 
but not D and access to another file with C and D, but not B. Without 
ACLs this is jut not possible without root setting up one group that 
encompasses B and C, and another for C and D. Obviously not a scalable 
or convenient solution.

This trivial example get's magnified when trying to delegate 
administration tasks on a large system. In these cases, groups could 
feasibly be set up to encompass every permutation, but can quickly get 
unwieldy.

I'm not at all opposed to capabilities, but I don't believe they come 
close to obviating ACLs. It also doesn't seem ACLs and capabilities are 
in any kind of conflict. Why could we not have both?

-Tupshin

