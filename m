Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262995AbRFAHpK>; Fri, 1 Jun 2001 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbRFAHpA>; Fri, 1 Jun 2001 03:45:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15109 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262995AbRFAHov>; Fri, 1 Jun 2001 03:44:51 -0400
Subject: Re: [CHECKER] 2.4.5-ac4 security holes
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Fri, 1 Jun 2001 08:42:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200106010449.VAA17373@csl.Stanford.EDU> from "Dawson Engler" at May 31, 2001 09:49:14 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155jZc-00009b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] looks really broken.
> /u2/engler/mc/oses/linux/2.4.5-ac4/fs/ioctl.c:108:sys_ioctl: ERROR:PARAM:70:108: Deref tainted var 'arg' (tainted from line 70)

Been meaning to dump that anyway so that was solved by the delete approach
- real bug

> [BUG] sure seems like it.  In general, all 4 dereferences seem pretty bad.
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/cosa.c:1049:cosa_download: ERROR:PARAM:1046:1049: Deref tainted var 'd' (tainted from line 1046)
> 		return -EPERM;

Fixed .. only available to root anyway

> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/cosa.c:1057:cosa_download: ERROR:PARAM:1046:1057: Deref tainted var 'd' (tainted from line 1046)
> 		return -EPERM;
> 	}
> 
Ditto

> 	switch (cmd) {
> 	case SNDCTL_SYNTH_INFO:
> 		memcpy (&((char *) arg)[0], &wavefront_info,

Fixed

> [BUG] [RESURRECTED]  Should be fixed in ac5, though.
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/eicon/linchr.c:128:do_ioctl: ERROR:PARAM:60:128: tainted var 'arg' (from line 60) used as arg 0 to 'DivasGetList'

Done (wasnt fixed in ac5)

