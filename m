Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUAERGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUAERGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:06:10 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6323 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265181AbUAERF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:05:57 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christophe Saout <christophe@saout.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 18:08:49 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl> <20040105035219.GA6393@leto.cs.pocnet.net>
In-Reply-To: <20040105035219.GA6393@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051808.49010.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of January 2004 04:52, Christophe Saout wrote:

> BTW, what was ide_multwrite expected to return? These if clauses in
> multwrite_intr are never executed.

Dunno.  It can't fail so it should be made void.

Please also add bio->bi_idx restoring for failed requests.
Put it before DRIVER(drive)->error() (and remember about if (bio) check).

Otherwise I patch is OK for me.

--bart

