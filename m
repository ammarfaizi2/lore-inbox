Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbSKPU5l>; Sat, 16 Nov 2002 15:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbSKPU5l>; Sat, 16 Nov 2002 15:57:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62993 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267356AbSKPU5k>;
	Sat, 16 Nov 2002 15:57:40 -0500
Message-ID: <3DD6B2C5.3010303@pobox.com>
Date: Sat, 16 Nov 2002 16:04:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com> <20021116151102.GI19015@higherplane.net>
In-Reply-To: <3DD5D93F.8070505@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:

> >If people want to get rivafb or an ancient ISA net driver building
> >again... patches welcome.  But I don't think calls for the kernel to
>
>
> yep, someone is maintaining ewrk3 again now :-), or at least i have seen
> a couple of patches submitted


hehe, yep, in fact there is an ewrk3 patch I still need to merge :)

> >compile 100 percent of the drivers is realistic or even reasonable.
> >Some of the APIs, particularly SCSI, are undergoing API stabilization.
>
>
> the api stabilization should have been happening months ago, in view of
> the october freeze


october freeze was for major features, not minor incremental tweaks...


> >And SCSI is an excellent example of drivers where
> >I-dont-have-test-hardware patches to fix compilation may miss subtle
> >problems -- and then six months later when the compileable-but-broken
> >SCSI driver is used by a real user, we have to spend more time in the
> >long run tracking down the problem.
>
>
> certainly, and sometimes i wonder if there could be a better way (than
> #error or #warning) to tag things as known broken.  currently people use
> #error during compile, but i'd like to see it show up in menuconfig
> somehow.


I respectfully disagree...  I think if these sort of FIXMEs show up in 
menuconfig, you're not only cluttering up menuconfig, you also moving 
past the level of programmer to the sysadmin/power-user level.  That 
seems like it would generate more bug reports than useful work.

About the only thing WRT menuconfig I would be ok with is commenting out 
majorly broken drivers until they are fixed...

	Jeff



