Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTFDPOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTFDPOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:14:37 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:19877
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263418AbTFDPOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:14:36 -0400
Date: Wed, 4 Jun 2003 11:28:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Stewart Smith <stewartsmith@mac.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Stewart Smith <stewart@linux.org.au>
Subject: Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols
Message-ID: <20030604152806.GE19929@gtf.org>
References: <1054646171.17921.64.camel@passion.cambridge.redhat.com> <3D3CD66D-9651-11D7-A060-00039346F142@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3CD66D-9651-11D7-A060-00039346F142@mac.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 03:56:09PM +1000, Stewart Smith wrote:
> +{
> +  return bitreverse(crc32_le(~0, data, length));
> +}
> +EXPORT_SYMBOL(ether_crc);
> +
> +static inline u32 ether_crc_le(size_t length, unsigned char const 
> *data)
> +{
> +  return crc32_le(~0, data, length);
> +}
> +EXPORT_SYMBOL(ether_crc_le);

You can't EXPORT_SYMBOL from a header.

This sounds like Kconfig or Makefile bugs to me... all the
export-symbol stuff should already be in place.

Can you post your .config and the exact build errors you are getting?

	Jeff



