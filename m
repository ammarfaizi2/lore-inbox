Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUCERS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUCERS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:18:58 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14731 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261964AbUCERSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:18:55 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: =?iso-8859-15?q?Fran=E7ois=20Chenais?= <francois@chenais.net>
Subject: Re: kernel 2.6.3 hdparm : HDIO_SET_DMA failed: Operation not permitted
Date: Fri, 5 Mar 2004 18:26:16 +0100
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1078506007.2210.84.camel@tanna>
In-Reply-To: <1078506007.2210.84.camel@tanna>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403051826.16650.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 of March 2004 18:00, François Chenais wrote:
> Hello,

Hi,

> Since I use kernel 2.6.3, my disk has very low performance
> If I do nothing during about 30 sec, the system takes about 3 sec before
> reaction because the disk seems awakened.
>
> So I asked around me how to tune it using hdparm but
> i have the following errors when setting on dma (logs bellow).
>
> Some persons around me have the same feeling of lowest performances.
>
>
> Perhaps my kernel .config has some bad values because I have no
> experience in disk tuning (see attached file).
>
> I use
>    - debian sid on a NEC VERSA L320 laptop with a 'home built' kernel.
>    - preemptive mode
>    - ACPI

CONFIG_BLK_DEV_PIIX is not set in your .config and due to the fact
that NEC VERSA L320 has Intel IDE chipset you need to set it to 'y'.

Regards,
Bartlomiej

