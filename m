Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268020AbUIFNzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268020AbUIFNzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUIFNzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:55:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268020AbUIFNzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:55:06 -0400
Date: Mon, 6 Sep 2004 14:55:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>, akpm@osdl.org,
       zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Change from EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL
Message-ID: <20040906145501.A30400@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>, akpm@osdl.org,
	zwane@linuxpower.ca, linux-kernel@vger.kernel.org
References: <20040903104239.A3077@infradead.org> <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com> <20040906.215512.861025296.takata.hirokazu@renesas.com> <20040906131106.GA8202@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040906131106.GA8202@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Sep 06, 2004 at 03:11:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 03:11:06PM +0200, Sam Ravnborg wrote:
> The convention these days is to put the EXPORT right uder the funtion definition
> when appropriate.
> 
> So something like:
> int foo(int l)
> {
> 	...
> }
> EXPORT_SYMBOL(foo);

Yes.

> No one just took their time to get rid of the rest of the *ksyms files.

There's a good reason why you won't get rid of them - it's called
assembly code.  EXPORT_SYMBOL doesn't work from the assembler.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
