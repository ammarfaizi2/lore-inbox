Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUE3VIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUE3VIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUE3VIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:08:01 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60596 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264461AbUE3VHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 17:07:48 -0400
Date: Sun, 30 May 2004 23:06:10 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040530210610.GC4681@apps.cwi.nl>
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <20040530204715.GB12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040530204715.GB12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 09:47:15PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> > Clearly, BLKGETSIZE is obsolescent - it should be replaced by
> > BLKGETSIZE64 everywhere. 2^41 B is 2 TB, and some RAIDs are larger.
> 
> ITYM "it should be replaced to lseek(fd, SEEK_END, 0) everywhere".

Roughly speaking, I agree (if you change that to lseek(fd, 0, SEEK_END)).

But in practice, now that we have BLKGETSIZE64, that is much more
convenient. How many bits does one get out of lseek? What is the size
of off_t? Is perhaps llseek needed? Or lseek64? Complications.

Andries
