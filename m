Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWCaVPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWCaVPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWCaVPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:15:18 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:55975 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932408AbWCaVPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:15:16 -0500
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 13:15:13 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311236.02665.david-b@pacbell.net> <A164CF6D-0330-46A7-ABF2-87127753E048@kernel.crashing.org>
In-Reply-To: <A164CF6D-0330-46A7-ABF2-87127753E048@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311315.14408.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 12:52 pm, Kumar Gala wrote:

> What I'm looking at is the following:
> 
> * use spi_bitbang_setup() as is
> * have my chipselect do:
> 	if (BITBANG_CS_INACTIVE)
> 		deassert GPIO pin for CS
> 	else
> 		set HW mode register (polarity, phase, bit length)
> 		assert GPIO pin for CS
> * setup_transfer()
> 	* set HW mode register (bit length)
> 	* call bitbang_setup_transfer()

And export bitbang_setup_transfer()?  I guess that makes sense,
but you should probably rename it then to match the convention for
the other exported symbols.

Once that's all working, please submit the relevant patch.

- Dave
