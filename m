Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUFXVCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUFXVCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUFXVAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:00:24 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:4619 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262380AbUFXVAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:00:08 -0400
Date: Thu, 24 Jun 2004 23:00:05 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Jason Mancini <xorbe@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/isofs/inode.c, 2-4GB files rejected on DVDs
Message-ID: <20040624210005.GI3072@pclin040.win.tue.nl>
References: <1088073870.17691.8.camel@xorbe.dyndns.org> <20040624150122.GB5068@apps.cwi.nl> <200406242058.56469@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406242058.56469@WOLK>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:58:56PM +0200, Marc-Christian Petersen wrote:

> Do we ever get interleaved files support with linux?

Well, you know how it is: either you implement this yourself, or
you provide enough details to enable someone else to implement this.

For example, suppose you dd the first megabyte off your DVD,
and make it available somewhere, or compress and uuencode and email it,
that might help.

> prolly ;) totally unrelated to this, but what about this:
> 
> Jun 24 20:46:01 codeman kernel: ISO 9660 Extensions: Microsoft Joliet Level 1
> Jun 24 20:46:01 codeman kernel: Interleaved files not (yet) supported.
> Jun 24 20:46:01 codeman kernel: File unit size != 0 for ISO file (60133376).
> Jun 24 20:46:01 codeman kernel: ISOFS: changing to secondary root
> Jun 24 20:46:01 codeman kernel: Interleaved files not (yet) supported.
> Jun 24 20:46:01 codeman kernel: File unit size != 0 for ISO file (60135424).
> 
> It's a 4,5GB ISO, edited with Magic ISO Maker under Windows, saved it, burned 
> it. Windows can handle the DVD very well. Linux just says the above and do not 
> give me any listing of the DVD.

You might try to get more details by undefining BEQUIET (in isofs/inode.c).

You might try to give the mount option -o nojoliet.

