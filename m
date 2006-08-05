Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161310AbWHEMsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWHEMsO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 08:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWHEMsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 08:48:14 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:57893 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161310AbWHEMsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 08:48:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KRkMurwk9EqfIj8mc87/FUV8XjvSJz10D0AVZntJmE8HZbRxHk2wJEYax/JE3CwCIx4JZSU1NLVqDosUJzgG+gkYyW4MsLk6oj0zK3giMJQ7baQZaYsTbGFCcOrd0Mc6Ieaq698s7qrp6SDMWrC8TwMnBfMytTyCP7TQxo2MwC8=
Message-ID: <44D49384.9060701@gmail.com>
Date: Sat, 05 Aug 2006 20:48:04 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: phreak@gentoo.org
CC: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] Updating Documentation/fb/vesafb.txt
References: <200608050902.20163.phreak@gentoo.org>
In-Reply-To: <200608050902.20163.phreak@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Heim wrote:
> Hello Antonino,
> 
> +    | 640x480  800x600  1024x768 1280x1024 1600x1200
> +----+-----------------------------------------------
> +256 |  0x301    0x303    0x305    0x307     0x???   
> +32k |  0x310    0x313    0x316    0x319     0x373   
> +64k |  0x311    0x314    0x317    0x31A     0x374   
> +16M |  0x312    0x315    0x318    0x31B     0x375   
>  
>  To enable one of those modes you have to specify "vga=ask" in the
>  lilo.conf file and rerun LILO. Then you can type in the desired

This is not correct. VESA did not define 1600x1200 as part of
its DVT standard. And starting with VBE 2.0, VESA is not going to
define new mode ID's. Thus the mode ID that you get for 1600x1200 may
be unique only for your particular hardware/Video BIOS.

You may use X's 'vesa' driver to get a list of modes that your
BIOS supports. It will be written to /var/log/X*.0.log.

Tony
