Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266945AbTGKWiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267004AbTGKWiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:38:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14777
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266945AbTGKWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:38:24 -0400
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307111544020.4337-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307111544020.4337-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057963814.20636.72.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 23:50:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 23:44, Linus Torvalds wrote:
> On 11 Jul 2003, Alan Cox wrote:
> > 
> > Lots of kernel drivers rely on the libc definition of strncpy. 
> 
> But that's ok. We _do_ do the padding. I hated it when I wrote it, but as 
> far as I know, the kernel strncpy() has done padding pretty much since day 
> one.

/**
 * strncpy - Copy a length-limited, %NUL-terminated string
 * @dest: Where to copy the string to
 * @src: Where to copy the string from
 * @count: The maximum number of bytes to copy
 *
 * Note that unlike userspace strncpy, this does not %NUL-pad the buffer.
 * However, the result is not %NUL-terminated if the source exceeds
 * @count bytes.
 */

Only x86 does the padding 

