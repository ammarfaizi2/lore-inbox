Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUHVQdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUHVQdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUHVQdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:33:20 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:2218 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268019AbUHVQdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:33:19 -0400
To: Christer Weinigel <christer@weinigel.se>
Cc: Pascal Schmidt <der.eremit@email.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
	<m37jrr40zi.fsf@zoo.weinigel.se>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 22 Aug 2004 18:33:18 +0200
In-Reply-To: <m37jrr40zi.fsf@zoo.weinigel.se>
Message-ID: <m33c2f3zg1.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/me keeping to the bad habit of following up to myself

Regarding the current 2.6.8 kernel, wouldn't it be a better idea to
move the CAP_SYS_RAWIO check to open time instead of when the ioctl is
called?  This would require a new flag somewhere in the file structure
I suppose, e.g. file->f_mode & FMODE_RAWIO.  

That would allow a suid root application to open the cdrom and then
drop all capabilities including RAWIO and would probably fit better
into how cdrecord expects things to work.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
