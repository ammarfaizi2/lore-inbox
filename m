Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268152AbTAKWXs>; Sat, 11 Jan 2003 17:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268155AbTAKWXs>; Sat, 11 Jan 2003 17:23:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35598 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268152AbTAKWXq>; Sat, 11 Jan 2003 17:23:46 -0500
Date: Sat, 11 Jan 2003 22:32:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sl82c105 driver update
Message-ID: <20030111223231.B21505@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1042302798.525.66.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1042302798.525.66.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Sat, Jan 11, 2003 at 05:33:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 05:33:19PM +0100, Benjamin Herrenschmidt wrote:
> Enclosed is an update to the sl82c105 driver against 2.4.21-pre3, I'll
> produce a 2.5 version once this is accepted by Alan.

Its still broken - if it uses DMA, the ide core will call ide_dma_on,
which will call config_for_dma(), which will call ide_config_drive_speed,
which will then call ide_dma_on, etc.

Sorry, I don't have a solution off hand for this.  I just wish that
the IDE core didn't change in these incompatible ways during a stable
kernel release.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

