Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWH3ExF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWH3ExF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 00:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWH3ExE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 00:53:04 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:37786 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964969AbWH3ExC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 00:53:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=twpUuI0KnI1nB3xQMLJ+WnFrc5BXpvT0ateIy3Qc3qWXoMMtZrFhjxjIhXr6l7SjyHQ9W/slFk9HOmLXMjzDfbpb5RDOpdWwY9fR6Vn5p3WlsFFZYIZziPEB64MRAUyNtkp9lgrwt8+pEG0RYyHOdOoSfOZc8PQyYMMHOL3X46U=  ;
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [Patch] Add spi full duplex mode transfer support
Date: Tue, 29 Aug 2006 21:52:57 -0700
User-Agent: KMail/1.7.1
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net
References: <489ecd0c0608292140m483bba2fqa300b55c5f4acf26@mail.gmail.com>
In-Reply-To: <489ecd0c0608292140m483bba2fqa300b55c5f4acf26@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608292152.58616.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 9:40 pm, Luke Yang wrote:
> Hi all,
> 
>    To enable full duplex mode spi transfer in Blackfin spi master
> driver, I need an extra field in spi_transfer structure. Attached the
> right format patch.

I don't understand.  ** ALL ** SPI transfers are full duplex.
If you want half duplex, just don't provide the buffer for the
transfer going in that direction (RX or TX).

Rejected ...


> Signed-off-by: Luke Yang <luke.adi@gmail.com>
> 
>  spi.h |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index c8bb680..99816eb 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -331,6 +331,7 @@ struct spi_transfer {
>         dma_addr_t      rx_dma;
> 
>         unsigned        cs_change:1;
> +       unsigned        is_duplex:1;
>         u8              bits_per_word;
>         u16             delay_usecs;
>         u32             speed_hz;
> 
> -- 
> Best regards,
> Luke Yang
> luke.adi@gmail.com
> 
