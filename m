Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbSKPPFm>; Sat, 16 Nov 2002 10:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbSKPPFl>; Sat, 16 Nov 2002 10:05:41 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:5387 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S267282AbSKPPFl>; Sat, 16 Nov 2002 10:05:41 -0500
Date: Sun, 17 Nov 2002 02:11:02 +1100
From: john slee <indigoid@higherplane.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021116151102.GI19015@higherplane.net>
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5DC77.2010406@pobox.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If people want to get rivafb or an ancient ISA net driver building 
> again... patches welcome.  But I don't think calls for the kernel to 

yep, someone is maintaining ewrk3 again now :-), or at least i have seen
a couple of patches submitted

> compile 100 percent of the drivers is realistic or even reasonable. 
> Some of the APIs, particularly SCSI, are undergoing API stabilization. 

the api stabilization should have been happening months ago, in view of
the october freeze

> And SCSI is an excellent example of drivers where 
> I-dont-have-test-hardware patches to fix compilation may miss subtle 
> problems -- and then six months later when the compileable-but-broken 
> SCSI driver is used by a real user, we have to spend more time in the 
> long run tracking down the problem.

certainly, and sometimes i wonder if there could be a better way (than
#error or #warning) to tag things as known broken.  currently people use
#error during compile, but i'd like to see it show up in menuconfig
somehow.

been thinking about it, but i haven't thought of a palatable solution
yet.  keeping the tag in the source files (as it is now) is probably a
good idea, but is suboptimal for external tools.  menuconfig doesn't
want to know about the actual source files

j.

-- 
toyota power: http://indigoid.net/
