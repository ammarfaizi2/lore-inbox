Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSGVIsi>; Mon, 22 Jul 2002 04:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGVIsi>; Mon, 22 Jul 2002 04:48:38 -0400
Received: from ns.suse.de ([213.95.15.193]:22284 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316587AbSGVIsh>;
	Mon, 22 Jul 2002 04:48:37 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.25 net/core/Makefile
References: <Pine.LNX.4.44.0207221032510.8911-100000@serv>
X-Yow: Boys, you have ALL been selected to LEAVE th' PLANET in 15 minutes!!
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 22 Jul 2002 10:51:43 +0200
In-Reply-To: <Pine.LNX.4.44.0207221032510.8911-100000@serv> (Roman Zippel's
 message of "Mon, 22 Jul 2002 10:37:41 +0200 (CEST)")
Message-ID: <jek7nof8m8.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

|> Hi,
|> 
|> On Mon, 22 Jul 2002, Russell King wrote:
|> 
|> > Wouldn't it be better to fix the existing config tools to output "=n"
|> > instead of "# CONFIG_foo is not set" ?  IIRC they do the translation
|> > back and forth internally anyway, so it should be just a matter of
|> > removing some code from the tools.
|> 
|> This would mean, tristate symbols had four states instead of three. The
|> current shell based config systems simply don't see all symbols.

They do, see for example load_config_file in scripts/Menuconfig, or around
line 556 in script/Configure.

|> Depending on the configuration a symbol could be unset or 'n'.

A symbol is unset if it does not occur in .config at all.  Having "#
CONFIG_foo is not set" in .config is completely the same as
"CONFIG_foo=n".

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
