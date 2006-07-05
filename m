Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWGEPsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWGEPsR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWGEPsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:48:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7891 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932243AbWGEPsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:48:16 -0400
Subject: Re: oops with 2.6.17.1 in vfs_statfs (maybe oprofile related)
From: Arjan van de Ven <arjan@infradead.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44ABDE30.6080307@drugphish.ch>
References: <44ABDE30.6080307@drugphish.ch>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 17:48:13 +0200
Message-Id: <1152114494.3201.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 17:43 +0200, Roberto Nibali wrote:
> Hello,
> 
> I'm slowly integrating 2.6.x kernel support and happen to hit a few
> oopses every now and then. So long as time permits I'll post them here.
> We have very intensive and complex test conducts since our distribution
> needs to be able to run across 2.2.x, 2.4.x and 2.6.x.
> 
> One of the tests I've performed was to oprofile a I/O intensive
> application while doing hotswap of the underlying SCSI disk in software
> raid mode, trying to monitor IPMI events in parallel. One of the oops I
> got was (and some sysrq fiddling):
> 
> Jul  5 16:38:11 BUG: unable to handle kernel paging request at virtual
> address f89d4888
> Jul  5 16:38:11 printing eip:
> Jul  5 16:38:11 c10510e0
> Jul  5 16:38:11 *pde = 00000000
> Jul  5 16:38:11 Oops: 0000 [#1]
> Jul  5 16:38:11 SMP
> Jul  5 16:38:11 Modules linked in: raid1 e1000 ipmi_si ipmi_devintf
> ipmi_msghandler ext3 jbd md_mod
> Jul  5 16:38:11 CPU:    0
> Jul  5 16:38:11 EIP:    0060:[<c10510e0>]    Tainted: G  R   VLI

you did an rmmod -f ...
is does this happen if you don't do that as well ?


