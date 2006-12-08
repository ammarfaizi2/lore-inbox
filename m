Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425358AbWLHK56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425358AbWLHK56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425359AbWLHK56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:57:58 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:58086 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425358AbWLHK55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:57:57 -0500
Subject: Re: [PATCH] hci endianness annotations
From: Marcel Holtmann <marcel@holtmann.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061208094855.GR4587@ftp.linux.org.uk>
References: <20061208094855.GR4587@ftp.linux.org.uk>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 12:58:01 +0100
Message-Id: <1165579081.5529.31.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

> ---
>  include/net/bluetooth/hci.h |    4 ++--
>  net/bluetooth/hci_sock.c    |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 10a3eec..41456c1 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -739,13 +739,13 @@ #define HCI_DEV_NONE	0xffff
>  struct hci_filter {
>  	unsigned long type_mask;
>  	unsigned long event_mask[2];
> -	__u16   opcode;
> +	__le16   opcode;
>  };
>  
>  struct hci_ufilter {
>  	__u32   type_mask;
>  	__u32   event_mask[2];
> -	__u16   opcode;
> +	__le16   opcode;
>  };
>  
>  #define HCI_FLT_TYPE_BITS	31
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 711a085..dbf98c4 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -123,10 +123,10 @@ void hci_send_to_sock(struct hci_dev *hd
>  			if (flt->opcode &&
>  			    ((evt == HCI_EV_CMD_COMPLETE &&
>  			      flt->opcode !=
> -			      get_unaligned((__u16 *)(skb->data + 3))) ||
> +			      get_unaligned((__le16 *)(skb->data + 3))) ||
>  			     (evt == HCI_EV_CMD_STATUS &&
>  			      flt->opcode !=
> -			      get_unaligned((__u16 *)(skb->data + 4)))))
> +			      get_unaligned((__le16 *)(skb->data + 4)))))
>  				continue;
>  		}
>  

