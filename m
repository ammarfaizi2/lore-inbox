Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbTIRLpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbTIRLpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:45:05 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:4109 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S261198AbTIRLo7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:44:59 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Date: Thu, 18 Sep 2003 13:44:57 +0200
User-Agent: KMail/1.5.9
References: <200309112357.41592.eu@marcelopenna.org> <200309121946.31810.adasi@kernel.pl> <bk43av$cp6$1%proserpine.haus@yggdrasl.demon.co.uk>
In-Reply-To: <bk43av$cp6$1%proserpine.haus@yggdrasl.demon.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309181344.57130.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia pon 15. wrze¶nia 2003 12:12, Adam Jones napisa³:
> In a futile gesture against entropy, Witold Krecicki wrote:
> > I've lost some of mails about siimage on LKML, but Im' getting more and
> > more confused about 'hangs' probably caused by siimage driver. I was
> > using 15 rqsize, now 128 - doesn't matter. It happens in random moments -
> > sometimes at boot time when drive is fscked, sometimes when I'm trying to
> > copy large amount of data and sometimes without any particular reason
> > after several hours.
>
> Out of interest, do you have some sort of SCSI controller in your
> system as well?  I've got a SiI3112 card and I get a hard lock-up pretty
> much as soon as anything touches the SCSI bus on my aic7xxx card.
> Disabling DMA on the SiI IDE channel seems to work around it, at the
> cost of a lot of performance... (this is on stock 2.4.22, BTW)
No, only on-board nForce2 IDE controller. Disabling ACPI helped. - now it's 
stable

> Setting rqsize to 128 seems perfectly stable for me - my drive reports
> itself as a ST380013AS (Seagate Barracuda 7200.7 SATA 80GB).
I use 128 too, and I've got 2xST3120026AS (Barracuda 7200.7 120GB) in software 
RAID0
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
