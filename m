Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVB0WXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVB0WXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVB0WXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:23:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51673 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261489AbVB0WXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:23:17 -0500
Date: Sun, 27 Feb 2005 22:23:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Erich Chen <erich@areca.com.tw>,
       linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: Re: [2.6.11-rc4-mm1 patch] drivers/scsi/arcmsr/arcmsr.c cleanups
Message-ID: <20050227222305.GA1847@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	Erich Chen <erich@areca.com.tw>, linux-kernel@vger.kernel.org,
	James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
References: <20050223014233.6710fd73.akpm@osdl.org> <20050227154810.GA6148@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227154810.GA6148@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 04:48:10PM +0100, Adrian Bunk wrote:
> - aren't the "if defined(__x86_64__)" wrong for other 64bit
>   architectures?

Yes.  Having arch or 64bit ifdefs is pretty wrong pretty much always.
In one case it's only used to make a typedef a 32bit or 64bit integeger,
that should be using unsigned long directly always, but the other uses
looks like real problems.

