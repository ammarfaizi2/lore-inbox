Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUFVPUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUFVPUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUFVPT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:19:26 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:19947 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264610AbUFVPLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:11:50 -0400
Date: Tue, 22 Jun 2004 17:11:45 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [patch] Re: 2.6.7-mm1 linker trouble with CONFIG_FB_RIVA_I2C=y and modular I2C
Message-ID: <20040622151144.GA11760@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@fs.tum.de>
References: <20040620174632.74e08e09.akpm@osdl.org> <20040621020627.GA10824@merlin.emma.line.org> <20040621152905.GC28607@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040621152905.GC28607@fs.tum.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, Adrian Bunk wrote:

> > drivers/built-in.o(.text+0xda101): In function `riva_setup_i2c_bus':
> > : undefined reference to `i2c_bit_add_bus'
> > drivers/built-in.o(.text+0xda218): In function `riva_delete_i2c_busses':
> > : undefined reference to `i2c_bit_del_bus'
> > drivers/built-in.o(.text+0xda237): In function `riva_delete_i2c_busses':
> > : undefined reference to `i2c_bit_del_bus'
> > drivers/built-in.o(.text+0xda2c9): In function `riva_do_probe_i2c_edid':
> > : undefined reference to `i2c_transfer'
> > make: *** [.tmp_vmlinux1] Error 1
> >...
> 
> Thanks for this report.

You're welcome.

> The problem is:
> FB_RIVA=y

FB_RIVA alone is not a problem with I²C and _ALGOBIT =m,
FB_RIVA_I2C introduces the link failure. But nevermind, the problem is
fixed for me with your patch.

> FB_RIVA_I2C=y
> I2C=m
> I2C_ALGOBIT=m
> 
> The patch below fixes this.

Danke!

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95
