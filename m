Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTDVFa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 01:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbTDVFa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 01:30:26 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:29446 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262932AbTDVFaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 01:30:25 -0400
Date: Tue, 22 Apr 2003 15:42:21 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: gordon anderson <gordonski_anderson@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 build - modules_install - depmod probs - 815fb / zlib -
 help
In-Reply-To: <20030422030917.12838.qmail@web40810.mail.yahoo.com>
Message-ID: <Mutt.LNX.4.44.0304221540520.3736-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, gordon anderson wrote:

> 
> Sorry if wrong forum!
> 
> Building 2.5.68 kernel with intel815 framebuffer support &
> crypto options.
> 
> make modules_install gives -
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.68/kernel/crypto/deflate.ko
> depmod:         zlib_inflateInit2_
> depmod:         zlib_inflate
> depmod:         zlib_inflate_workspacesize
> depmod:         zlib_deflateInit2_
> depmod:         zlib_deflate_workspacesize
> depmod:         zlib_deflate
> depmod:         zlib_inflateReset
> depmod:         zlib_deflateReset

You need CONFIG_ZLIB_INFLATE and CONFIG_ZLIB_DEFLATE for crypto/deflate.c, 
which is provided by the default Kconfig.


- James
-- 
James Morris
<jmorris@intercode.com.au>

