Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265618AbRFWESm>; Sat, 23 Jun 2001 00:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265620AbRFWESc>; Sat, 23 Jun 2001 00:18:32 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:49845 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S265618AbRFWESU>; Sat, 23 Jun 2001 00:18:20 -0400
Message-ID: <3B3418EB.E9F3F461@idcomm.com>
Date: Fri, 22 Jun 2001 22:19:55 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Cleanup kbuild for aic7xxx
In-Reply-To: <200106221939.f5MJdjU78255@aslan.scsiguy.com> <10972.993257428@ocs3.ocs-net> <20010623032047.A14928@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On 20010623 Keith Owens wrote:
> >
> >>What again are you trying to fix?  It looks to me like you are simply
> >>trying to make it harder for people actually working on the aic7xxx
> >>driver to have proper dependencies.
> >
> >The patch still works for anybody changing the aic7xxx firmware or the
> >aicasm code.  Any change to the generated files or the aicasm files now
> >forces a rebuild, the option is not required.  Only people changing
> >aic7xxx firmware are affected, instead of everybody.
> >
> 
> It is easier than that. Nobody should be rebuilding the firmware apart
> from driver mantainers. If driver version in 2.4.5 is 6.1.13, that version
> includes a certain firmware in .h format and that is all. Apart from
> this, the author (Justin) can make available in his web page one other
> package for driver testers or developers including aicasm and firmware
> source. But that should not be in the kernel tree.
> If there are updates to the firmware, just send the patch for .h files
> to kernel mantainers and/or lkml, as everybody does.
> 
> This is easier, doesn't it ?

It would cause problems for me. Perhaps it is an issue of XFS filesystem
patches, rather than the regular kernel, I don't know what it modifies
relative to aic7xxx. But so far all of my recent test kernels will fail
to complete boot correctly if rebuild firmware is not used.

D. Stimits, stimits@idcomm.com

> 
> --
> J.A. Magallon                           #  Let the source be with you...
> mailto:jamagallon@able.es
> Mandrake Linux release 8.1 (Cooker) for i586
> Linux werewolf 2.4.5-ac17 #2 SMP Fri Jun 22 01:36:07 CEST 2001 i686
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
