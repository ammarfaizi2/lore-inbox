Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWJPUKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWJPUKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWJPUKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:10:13 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:6834 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1161032AbWJPUKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:10:11 -0400
Date: Mon, 16 Oct 2006 22:10:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Scott Baker <smbaker@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exported module symbols and warnings
Message-ID: <20061016201010.GC32232@uranus.ravnborg.org>
References: <35a82d00610161135t3d65bf2ei46631e69bf6f7f12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a82d00610161135t3d65bf2ei46631e69bf6f7f12@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 11:35:13AM -0700, Scott Baker wrote:
> Hello,
> 
> I'm developing a pair of kernel modules. One module needs to export a
> symbol that will be used by the second module. I'm doing this by using
> EXPORT_SYMBOL(MySymbol) in the first module and declaring the symbol
> as extern in the second module. It works fine.
> 
> However, there are a couple of warnings that I'm trying to clean up.
> The first is when building the second module (the one that uses the
> symbol). It is: "*** Warning: "MySymbol" [filename] undefined!"
> 
> The second warning occurs when insmod'ing the second module. It is:
> "no version for "MySymbol" found: kernel tainted."
> 
> Can someone point me in the right direction? The modules are behaving
> fine, but the warning messages are a bit unsightly.
Try to read Documentation/kbuild/modules.txt - here you will read that
the trick is to use a common kbuild file for both modules.

And that should fix your "no version" error too since you will
then know the version info during build time.

	Sam
