Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267220AbSKPFnW>; Sat, 16 Nov 2002 00:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbSKPFnW>; Sat, 16 Nov 2002 00:43:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267220AbSKPFnV>;
	Sat, 16 Nov 2002 00:43:21 -0500
Message-ID: <3DD5DC77.2010406@pobox.com>
Date: Sat, 16 Nov 2002 00:49:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
References: <3DD5D93F.8070505@kegel.com>
In-Reply-To: <3DD5D93F.8070505@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:

> john slee  wrote:
>
> > now 2.5-bk is far from it.  last i checked allmodconfig (a couple of
> > days ago) there was major breakage all over llc, scsi, video, sound, ...
> > which kinda masks any breakages you might have introduced.
>
> Hrmph.  Y'know, maybe it's time for us to collectively put our
> feet down, get 2.5-linus to the point where everything compiles,
> and keep it there.  After all, we are supposedly trying to
> *stabilize* 2.5.  It isn't stable if it doesn't compile...


Most of the stuff that doesn't compile (or link) is typically stuff that 
is lesser used, or never used.  A lot of the don't-compile complaints 
seem to be vocal-minority type complaints or "why can't I build _every_ 
module in the kernel?" complaints.  Ref allmodconfig, above.

If people want to get rivafb or an ancient ISA net driver building 
again... patches welcome.  But I don't think calls for the kernel to 
compile 100 percent of the drivers is realistic or even reasonable. 
Some of the APIs, particularly SCSI, are undergoing API stabilization. 
And SCSI is an excellent example of drivers where 
I-dont-have-test-hardware patches to fix compilation may miss subtle 
problems -- and then six months later when the compileable-but-broken 
SCSI driver is used by a real user, we have to spend more time in the 
long run tracking down the problem.

But like I said, patches welcome.

	Jeff



