Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUHVWRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUHVWRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267600AbUHVWRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:17:15 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:33452 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S267585AbUHVWRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:17:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christer Weinigel <christer@weinigel.se>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
	<m37jrr40zi.fsf@zoo.weinigel.se> <m33c2f3zg1.fsf@zoo.weinigel.se>
	<1093191541.24759.1.camel@localhost.localdomain>
	<m3pt5j2i79.fsf@zoo.weinigel.se>
	<1093207625.25039.15.camel@localhost.localdomain>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 23 Aug 2004 00:17:09 +0200
In-Reply-To: <1093207625.25039.15.camel@localhost.localdomain>
Message-ID: <m3d61i3jiy.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Its not an easy trade off- I don't know if there is a right answer.
> Despite the UI problems in both cdrecord and its author the internal
> code is actually quite rigorous so its something I'd be more comfortable
> giving limited rawio access than quite a few other apps that touch
> external public data.

Another way would be to add a scsi ioctl such as ENABLE_SG_IO or an
open flag, e.g. open("/dev/hdc", ... | O_RAWIO) which needs
CAP_SYS_RAWIO.  That way it is much less likely that the RAWIO
permission is given away by mistake, but I must admit that it feels
kind of ugly.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
