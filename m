Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266201AbUFWPHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUFWPHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUFWPHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:07:34 -0400
Received: from [213.146.154.40] ([213.146.154.40]:6040 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266549AbUFWPGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:06:15 -0400
Date: Wed, 23 Jun 2004 16:06:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, erikj@sgi.com
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040623150611.GA24244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, erikj@sgi.com
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 09:48:43AM -0500, Pat Gefre wrote:
> 
> I'm resending with the signed-off line.... sorry I forgot it.
> 
> 
> 2.6 patch for our console driver. We converted the driver to use the
> serial core functions. Also some changes to use sysfs/udev and a
> different major number.

Please include <linux/serial_core.h> before <asm/*.h> headers and kill
the !SYSFS_ONLY code as long as you don't have a device number assigned.
Patch looks okay to me otherwise, but maybe rmk should take a look, too.

