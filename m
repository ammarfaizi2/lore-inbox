Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUFCP2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUFCP2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUFCPYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:24:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:63157 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264850AbUFCPLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:11:51 -0400
Date: Thu, 3 Jun 2004 17:11:47 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Frediano Ziglio <freddyz77@tin.it>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040603151147.GB820@apps.cwi.nl>
References: <40BA2213.1090209@pobox.com> <20040603103907.GV23408@apps.cwi.nl> <1086265833.3988.13.camel@freddy> <200406031635.38718.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406031635.38718.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 04:35:38PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > Yes and not... HDIO_GETGEO still exists and report inconsistent
> > informations. IMHO should be removed. I know this breaks some existing
> > programs however these programs do not actually works correctly.
> 
> Hm, you are right - HDIO_GETGEO returns different information in 2.4 and 2.6.
> 
> Andries, what is your opinion?

HDIO_GETGEO returns 4 fields.

There is unsigned long start; giving the starting cylinder
of a partition. It is valid, and there is some software that
uses it. It will work until the disks get larger than 2 TB
(that is, today).
And there are heads, sectors, cylinders.
This is mostly garbage. Naive use is not recommended.
Semantics in 2.0 / 2.2 / 2.4 / 2.6 all different.

> You can export needed information through /proc/ide/.

Not recommended.

Andries

