Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266415AbTGERCh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 13:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266419AbTGERCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 13:02:37 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:6414 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S266415AbTGERCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 13:02:34 -0400
Date: Sun, 6 Jul 2003 03:16:09 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
cc: Christoph Hellwig <hch@infradead.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@osdl.org>, <Andries.Brouwer@cwi.nl>,
       <akpm@digeo.com>, <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [PATCH] cryptoloop
In-Reply-To: <3F068F49.1883BE0D@pp.inet.fi>
Message-ID: <Mutt.LNX.4.44.0307060312520.21967-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jul 2003, Jari Ruusu wrote:

> This tests only low level cipher functions aes_encrypt() and aes_decrypt()
> from linux-2.5.74/crypto/aes.c with all CryptoAPI overhead removed. In real
> use, including CryptoAPI overhead, these numbers should be a little bit
> smaller.
> 
> key length 128 bits, encrypt speed 68.5 Mbits/sec
> key length 128 bits, decrypt speed 58.9 Mbits/sec
> key length 192 bits, encrypt speed 58.3 Mbits/sec
> key length 192 bits, decrypt speed 50.3 Mbits/sec
> key length 256 bits, encrypt speed 51.0 Mbits/sec
> key length 256 bits, decrypt speed 43.8 Mbits/sec

[snip]

> This tests aes_encrypt() and aes_decrypt() from loop-AES-v1.7d/aes.c
> Loop-AES users running non-x86 kernels or x86 configured for i386/i486 will
> run this version.
> 
> key length 128 bits, encrypt speed 81.2 Mbits/sec
> key length 128 bits, decrypt speed 83.4 Mbits/sec
> key length 192 bits, encrypt speed 68.5 Mbits/sec
> key length 192 bits, decrypt speed 70.6 Mbits/sec
> key length 256 bits, encrypt speed 58.9 Mbits/sec
> key length 256 bits, decrypt speed 60.9 Mbits/sec

These results are interesting, if they represent a pure comparison of the
crypto algorithm implementations -- both the mainline kernel version and
yours are based on the same Gladman code.


- James
-- 
James Morris
<jmorris@intercode.com.au>

