Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUFXTHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUFXTHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUFXTHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:07:47 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:36108 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264771AbUFXTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:04:11 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: [PATCH] fs/isofs/inode.c, 2-4GB files rejected on DVDs
Date: Thu, 24 Jun 2004 20:58:56 +0200
User-Agent: KMail/1.6.2
Cc: Jason Mancini <xorbe@sbcglobal.net>, linux-kernel@vger.kernel.org
References: <1088073870.17691.8.camel@xorbe.dyndns.org> <20040624150122.GB5068@apps.cwi.nl>
In-Reply-To: <20040624150122.GB5068@apps.cwi.nl>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200406242058.56469@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 June 2004 17:01, Andries Brouwer wrote:

> Config item? No. There are far too many.
> Automatically enabling? No - that code must be deleted, like you did.
> Anyone with such a CDROM can give the "cruft" mount option herself.
> Testing for negative i_size? But it only becomes negative when
> some earlier code is broken, so probably we should fix that
> earlier code instead.
> More in particular, I read ISO 9660 section 7.3.3 as talking about
> unsigned integers. Only in 7.1.2 do signed integers occur.
> So, I suppose changing isonum_733 to return unsigned should suffice.
> Could you test the below?

prolly ;) totally unrelated to this, but what about this:

Jun 24 20:46:01 codeman kernel: ISO 9660 Extensions: Microsoft Joliet Level 1
Jun 24 20:46:01 codeman kernel: Interleaved files not (yet) supported.
Jun 24 20:46:01 codeman kernel: File unit size != 0 for ISO file (60133376).
Jun 24 20:46:01 codeman kernel: ISOFS: changing to secondary root
Jun 24 20:46:01 codeman kernel: Interleaved files not (yet) supported.
Jun 24 20:46:01 codeman kernel: File unit size != 0 for ISO file (60135424).

It's a 4,5GB ISO, edited with Magic ISO Maker under Windows, saved it, burned 
it. Windows can handle the DVD very well. Linux just says the above and do not 
give me any listing of the DVD.

Do we ever get interleaved files support with linux?

ciao, Marc

