Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTKKS3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTKKS3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:29:41 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56502 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263702AbTKKS3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:29:39 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: IDE disk information changed from 2.4 to 2.6
Date: Tue, 11 Nov 2003 19:29:08 +0100
User-Agent: KMail/1.5.4
Cc: Flavio Bruno Leitner <fbl@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
References: <20031105184203.GG5304@conectiva.com.br> <Pine.SOL.4.30.0311052031510.1988-100000@mion.elka.pw.edu.pl> <20031111115316.GB16163@win.tue.nl>
In-Reply-To: <20031111115316.GB16163@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311111929.08487.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 of November 2003 12:53, Andries Brouwer wrote:
> On Wed, Nov 05, 2003 at 08:41:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > In 2.6.x it doesn't even read BIOS info (which is wrong IMO, it should
> > do this but only as last resort - if partition can't be mounted).
>
> How can reading information that is not used by any kernel
> help in mounting a partition?

You are of course right, only ibm.c and nec98.c use HDIO_GETGEO.

> > Difference in CHS translation should matter only if you have some old DOS
> > partitions created using CHS information.  Then you can force geometry
> > using boot parameter "hd?=".  Unfortunately I've seen recently bugreport
> > when 2.4.20 (?) works and 2.6.x fails even with forced geometry.
>
> Fails? What do you mean?

Sorry, it was "hd.c instead of ide.c" problem.

> (Are you referring to the problem of finding the last cylinder?)

