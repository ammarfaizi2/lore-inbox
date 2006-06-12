Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWFLRhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWFLRhM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWFLRhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:37:11 -0400
Received: from xenotime.net ([66.160.160.81]:2197 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750803AbWFLRhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:37:09 -0400
Date: Mon, 12 Jun 2006 10:39:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CRC ITU-T V.41
Message-Id: <20060612103954.1f2a1f0e.rdunlap@xenotime.net>
In-Reply-To: <200606121932.37990.IvDoorn@gmail.com>
References: <200606121617.08791.IvDoorn@gmail.com>
	<20060612100942.62ad4d0e.rdunlap@xenotime.net>
	<200606121932.37990.IvDoorn@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 19:32:34 +0200 Ivo van Doorn wrote:

> On Monday 12 June 2006 19:09, Randy.Dunlap wrote:
> > On Mon, 12 Jun 2006 16:17:04 +0200 Ivo van Doorn wrote:
> > 
> 
> > > +/**
> > > + * Compute the CRC-ITU-T for the data buffer
> > 
> > Please use Linux kernel-doc format.  See
> > Documentation/kernel-doc-nano-HOWTO.txt.  Basically:
> 
> Ah ok. I just followed the crc16 approach.

OK, I'll plan to fix that file's kernel-doc then.

> >  * crc_itu_t - compute the CRC-ITU-T for the data buffer
> > 
> > and make parameter changes below:
> > 
> > > + *
> > > + * @param crc     previous CRC value
> > > + * @param buffer  data pointer
> > > + * @param len     number of bytes in the buffer
> > 
> >  * @crc:	previous CRC value
> >  * @buffer:	data pointer
> >  * @len:	number of bytes in the buffer
> >  *
> >  * Returns the updated CRC value.
> > 
> > > + * @return        the updated CRC value
> > > + */
> > > +u16 crc_itu_t(u16 crc, const u8 *buffer, size_t len)
> > > +{
> 
> The updated patch would then become:
> 
> Signed-off-by Ivo van Doorn <IvDoorn@gmail.com>
> 
> ---
> 
> +/**
> + * crc_itu_t - Compute the CRC-ITU-T for the data buffer
> + *
> + * @crc previous CRC value
> + * @buffer data pointer
> + * @len number of bytes in the buffer

The kernel-doc doc. says to put a colon after each parameter name,
so please do that too.  Otherwise looks good, thanks.


> + *
> + * Returns the updated CRC value
> + */
> +u16 crc_itu_t(u16 crc, const u8 *buffer, size_t len)
> +{


---
~Randy
