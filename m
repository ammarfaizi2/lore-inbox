Return-Path: <linux-kernel-owner+w=401wt.eu-S1762901AbWLKN0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762901AbWLKN0T (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762903AbWLKN0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:26:19 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:1850 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762901AbWLKN0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:26:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nFJ0oVzrvw+gb6bD2qCDGmOzPZwfuc1TxPfdWg7cq/dJCJXFFe7F1UKqU/nV3dTm+2PkhSj9t1UB9/6YZCK0ueiT8AyjNM5ZSeXx1WvHs6PjEMsPNVypPZn3hZvP/3tQ4zeBnreJ99/1IFNRM7DL/w8AFQ1Hj7HjDqVoY+aAsbc=
Date: Mon, 11 Dec 2006 22:25:40 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Mark bitrevX() functions as const
Message-ID: <20061211132540.GA4629@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <29447.1165840536@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29447.1165840536@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:35:36PM +0000, David Howells wrote:
> diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
> index 05e540d..032056b 100644
> --- a/include/linux/bitrev.h
> +++ b/include/linux/bitrev.h
> @@ -5,11 +5,11 @@ #include <linux/types.h>
>  
>  extern u8 const byte_rev_table[256];
>  
> -static inline u8 bitrev8(u8 byte)
> +static inline __attribute__((const)) u8 bitrev8(u8 byte)
>  {
>  	return byte_rev_table[byte];
>  }
>  
> -extern u32 bitrev32(u32 in);
> +extern __attribute__((const)) u32 bitrev32(u32 in);
>  
>  #endif /* _LINUX_BITREV_H */

__attribute_pure__ ?

