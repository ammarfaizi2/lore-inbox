Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUHVVXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUHVVXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUHVVXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:23:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:20640 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S266173AbUHVVXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:23:23 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: der.eremit@email.de, christer@weinigel.se, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
	<m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner>
From: Julien Oster <lkml-7994@mc.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	der.eremit@email.de, christer@weinigel.se,
	linux-kernel@vger.kernel.org, axboe@suse.de
Date: Sun, 22 Aug 2004 23:29:47 +0200
In-Reply-To: <4128CAA2.nail9RG21R1OG@burner> (Joerg Schilling's message of
 "Sun, 22 Aug 2004 18:32:34 +0200")
Message-ID: <87wtzq275g.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

> But in order to rip an audio CD, you need to use e.g. MODE SELECT.
> If you start to distinct safe SCSI commands from possibly unsafe ones, then 
> MODE SELECT could not be in the list of safe ones.

That is why I'm proposing an empty filter at boot time, which allows
no SG_IO except when having CAP_SYS_RAWIO (which enables everything)
and the possibility to open up certain commands from userspace later.

Julien
