Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbULHNxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbULHNxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbULHNxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:53:24 -0500
Received: from [213.146.154.40] ([213.146.154.40]:14743 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261216AbULHNxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:53:20 -0500
Date: Wed, 8 Dec 2004 13:53:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, Eric Wood <eric@interplas.com>,
       bmckinlay@perle.com, tmckinlay@perle.com
Subject: Re: [PATCH] generic-serial
Message-ID: <20041208135314.GA31975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick van de Lageweg <patrick@bitwizard.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Eric Wood <eric@interplas.com>, bmckinlay@perle.com,
	tmckinlay@perle.com
References: <20041208132938.GB19937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208132938.GB19937@bitwizard.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 02:29:38PM +0100, Patrick van de Lageweg wrote:
> Hi,
> 
> This patch converts all save_flags/restore_flags to the new 
> spin_lick_irqsave/spin_unlock_irqrestore calls, as well as some
> other 2.6.X cleanups. This prepares the way for the "io8+",
> "sx" and "rio" drivers to become SMP safe. Patches for those
> drivers follow. 

I'd really prefer moving those drivers over to the new serial core
framework than sticking more work into that obsolete code.

