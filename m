Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbUK3Sg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbUK3Sg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUK3SeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:34:23 -0500
Received: from [213.146.154.40] ([213.146.154.40]:16864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262241AbUK3SaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:30:24 -0500
Date: Tue, 30 Nov 2004 18:30:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041130183023.GA26895@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041130095045.090de5ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +x86_64-make-irda-devices-are-not-really-isa-devices-not.patch

This one is still as bogus as it was when discussed last time.  The
irda devices do need ISA DMA, which isn't supported by most architectures
that don't have CONFIG_ISA.  So we'll allow selecting a driver that's
not compilable for the non-PeCee users in the world.
