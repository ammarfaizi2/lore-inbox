Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSLONj7>; Sun, 15 Dec 2002 08:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSLONj7>; Sun, 15 Dec 2002 08:39:59 -0500
Received: from bitute.b4net.lt ([213.190.43.225]:27784 "EHLO mg.homelinux.net")
	by vger.kernel.org with ESMTP id <S261398AbSLONj7>;
	Sun, 15 Dec 2002 08:39:59 -0500
Date: Sun, 15 Dec 2002 15:47:28 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: How to do -nostdinc?
Message-ID: <20021215134728.GA8248@mg.home>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1357.1039954001@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1357.1039954001@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://www.b4net.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://www.b4net.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 11:06:41PM +1100, Keith Owens wrote:
> There are two ways of setting the -nostdinc flag in the kernel Makefile :-
> 
> (1) -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> (2) -nostdinc -iwithprefix include
> 
> The first format breaks with non-English locales, however the fix is trivial.
> 
> (1a) -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

Wouldn't LC_ALL=C be more reliable?

Marius Gedminas
-- 
No proper program contains an indication which as an operator-applied
occurrence identifies an operator-defining occurrence which as an
indication-applied occurrence identifies an indication-defining occurrence
different from the one identified by the given indication as an
indication-applied occurrence.
                -- ALGOL 68 Report
