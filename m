Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbRF3JUp>; Sat, 30 Jun 2001 05:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbRF3JUf>; Sat, 30 Jun 2001 05:20:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264874AbRF3JU1>;
	Sat, 30 Jun 2001 05:20:27 -0400
Date: Sat, 30 Jun 2001 10:20:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010630102024.A12009@flint.arm.linux.org.uk>
In-Reply-To: <200106300435.VAA14173@adam.yggdrasil.com> <E15GF94-0001h6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15GF94-0001h6-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jun 30, 2001 at 08:26:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 08:26:22AM +0100, Alan Cox wrote:
> #2
> 	dep_tristate $FOO $BAR
> 
> to say 'FOO requires BAR and must be a similar setting _IF_CONFIGURED_'

Err, how can $BAR be undefined?  Configure sets all config variables which
are answered with 'n' to 'n'.

Therefore, if you do:

bool 'PNP?' PNP

dep_tristate 'FOO?' FOO $PNP

and you answer 'n' to PNP, then FOO will be 'n'.

Can you extract an example where #2 is actually used?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

