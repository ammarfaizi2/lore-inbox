Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUHWLmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUHWLmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUHWLmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 07:42:05 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:13749 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263024AbUHWLmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 07:42:01 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Aug 2004 13:40:52 +0200
To: schilling@fokus.fraunhofer.de, lkml-7994@mc.frodoid.org
Cc: linux-kernel@vger.kernel.org, der.eremit@email.de, christer@weinigel.se,
       axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4129D7C4.nailA9B114PTI@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
 <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
 <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner>
 <87wtzq275g.fsf@killer.ninja.frodoid.org>
In-Reply-To: <87wtzq275g.fsf@killer.ninja.frodoid.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster <lkml-7994@mc.frodoid.org> wrote:

> Joerg Schilling <schilling@fokus.fraunhofer.de> writes:
>
> > But in order to rip an audio CD, you need to use e.g. MODE SELECT.
> > If you start to distinct safe SCSI commands from possibly unsafe ones, then 
> > MODE SELECT could not be in the list of safe ones.
>
> That is why I'm proposing an empty filter at boot time, which allows
> no SG_IO except when having CAP_SYS_RAWIO (which enables everything)
> and the possibility to open up certain commands from userspace later.

If the related /dev/* nodes are owned by root and set up rw-r-r or worse 
for others and requiring write access to send SCSI commands, then you get
the same kind of authentification, but cdrecord would continue to work.

Only if someone would chown the related /dev/* nodes to a user differen from 
root there would be a difference.

P.S.: UNIX philosohy is to allow the administrator to set up bad/wrong permissions.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
