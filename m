Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTB0WCp>; Thu, 27 Feb 2003 17:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTB0WCp>; Thu, 27 Feb 2003 17:02:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13069 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267131AbTB0WCo>; Thu, 27 Feb 2003 17:02:44 -0500
Date: Thu, 27 Feb 2003 22:13:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: update register_pcmcia_driver users
Message-ID: <20030227221301.C16645@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@brodo.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030227184110.GA22487@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030227184110.GA22487@brodo.de>; from linux@brodo.de on Thu, Feb 27, 2003 at 07:41:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 07:41:10PM +0100, Dominik Brodowski wrote:
> +static struct pcmcia_driver airo_driver = {
> +       .drv.name       = "airo_cs",

Can we stop doing this please, and instead write it as:

	.drv = {
		.name	= "airo_cs",
	},

I'd like the kernel to remain buildable on the stable compilers suitable
for ARM targets, namely gcc 2.95.3 and gcc 2.95.4.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

