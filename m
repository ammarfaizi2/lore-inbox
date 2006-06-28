Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423202AbWF1H3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423202AbWF1H3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423203AbWF1H3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:29:12 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:59582 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1423202AbWF1H3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:29:10 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 28 Jun 2006 09:29:07 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read  
 atip wiith cdrecord
Message-ID: <44A22FC3.nail3NU1XXW6C@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Lohmaier wrote:
>I updated the bug-report with some info I collected from another bug. 

>Apparently my drive sends additional interrupts that confuses the kernel 
>and make it hang. 
>The problem is triggered with newer versions of cdrecord (cdrtools 
>2.01a33 and newer) where cdrecord changed its driver interface. 

cdrtools-2.01a33 is extremely old (2 years).

It did not introduce new SCSI commands (compared to prevuious versions) and I
would be interested why this problem is discussed late.

The only new thing with cdrecord-2.01a33 is that it started to transfer more 
than 4 bytes with the "read buffer" command. As this is only issued in case that
the "read buffer" command did succeed with 4 bytes transfer count and as 
cdrecord does not transfer more than the drive advertizes, I am just depending 
on a kernel that does not freeze from the SCSI command I am issuing.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
