Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUA3SxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUA3SxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:53:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262052AbUA3SxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:53:16 -0500
Date: Fri, 30 Jan 2004 13:53:06 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: arnd@arndb.de, <linux-kernel@vger.kernel.org>, <rspchan@starhub.net.sg>
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
In-Reply-To: <Xine.LNX.4.44.0401301335210.16592-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401301351140.16644-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, James Morris wrote:

> On Fri, 30 Jan 2004, Randy.Dunlap wrote:
> 
> > Here's what I see on x86 and gcc 3.2 (for Linux 2.6.1).
> > What Linux version of the code are you looking at?
> > 
> > 
> > $0x180,%esp: c01fd5aa <aes_encrypt+4/1750>
> > $0x1b0,%esp: c01fecfa <aes_decrypt+4/17da>
> > $0x230,%esp: c0206acd <test_deflate+b/2f8>
> > $0x10c,%esp: c0205c90 <test_hmac+6/4fc>
> > $0x1fc,%esp: c01e9ed8 <sha1_transform+4/178a>
> > $0x120,%esp: c01eb842 <sha256_transform+6/1ef0>
> > $0x384,%esp: c01ed988 <sha512_transform+4/17e8>
> > $0x10c,%esp: c01f1c90 <twofish_setkey+4/7480>
> > 
> 
> 2.6.2-rc2-mm2 with gcc version 3.3.1 20030915 (Red Hat Linux 3.3.1-5)
> 

Actually, 24 bytes (not 8):

c02120b0 <twofish_setkey>:
c02120b0:       55                      push   %ebp
c02120b1:       57                      push   %edi
c02120b2:       56                      push   %esi
c02120b3:       53                      push   %ebx
c02120b4:       83 ec 18                sub    $0x18,%esp



- James
-- 
James Morris
<jmorris@redhat.com>


