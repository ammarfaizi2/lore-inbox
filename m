Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267960AbTBRW7O>; Tue, 18 Feb 2003 17:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268088AbTBRW7N>; Tue, 18 Feb 2003 17:59:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32526 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267960AbTBRW7L>; Tue, 18 Feb 2003 17:59:11 -0500
Date: Tue, 18 Feb 2003 23:09:10 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
Message-ID: <20030218230910.A27653@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <E18lC5R-00067P-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E18lC5R-00067P-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 18, 2003 at 06:03:21PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 06:03:21PM +0000, Alan Cox wrote:
> +static u8 ide_unplugged_inb (unsigned long port)
> +{
> +	return 0xFF;
> +}

Shouldn't this return 0x7f, ie bit 7 clear, as if we have an interface
without drive attached?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

