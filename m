Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbTDUBUe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 21:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTDUBUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 21:20:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44540 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263748AbTDUBUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 21:20:33 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 21 Apr 2003 03:32:34 +0200 (MEST)
Message-Id: <UTC200304210132.h3L1WY215924.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hpa@zytor.com
Subject: Re: [CFT] more kdev_t-ectomy
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> We do need a dev32_t for NFSv2 et al, though.

>>  don't know why.

> So we can have (k)dev_t_to_dev32() for NFSv2 et al

That is something private to the NFS code.
The standard leaves the structure undefined, so whatever we do is OK.
It seems reasonable to allow some mount option to specify
whether the other side is Solaris-like, with 8:8 / 14:18,
or FreeBSD-like, with 8:24, or Linux like ...

Filesystems that are offered more dev_t bits than they can handle
must just return -EOVERFLOW.

Andries

