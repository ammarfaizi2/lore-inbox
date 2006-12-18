Return-Path: <linux-kernel-owner+w=401wt.eu-S1753302AbWLRAki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbWLRAki (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbWLRAki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 19:40:38 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42174 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbWLRAkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 19:40:37 -0500
Message-ID: <4585E37C.7040105@us.ibm.com>
Date: Sun, 17 Dec 2006 16:40:28 -0800
From: Sridhar Samudrala <sri@us.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] net/sctp/: make 2 functions static
References: <20061216135703.GE3388@stusta.de>
In-Reply-To: <20061216135703.GE3388@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes the following needlessly global functions static:
> - ipv6.c: sctp_inet6addr_event()
> - protocol.c: sctp_inetaddr_event()
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>   
Acked-by: Sridhar Samudrala <sri@us.ibm.com>

Thanks
Sridhar
> ---
>
>  include/net/sctp/sctp.h |    2 --
>  net/sctp/ipv6.c         |    4 ++--
>  net/sctp/protocol.c     |    4 ++--
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> --- linux-2.6.20-rc1-mm1/net/sctp/ipv6.c.old	2006-12-16 01:05:15.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/net/sctp/ipv6.c	2006-12-16 01:05:40.000000000 +0100
> @@ -79,8 +79,8 @@
>  #include <asm/uaccess.h>
>
>  /* Event handler for inet6 address addition/deletion events.  */
> -int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
> -                        void *ptr)
> +static int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
> +				void *ptr)
>  {
>  	struct inet6_ifaddr *ifa = (struct inet6_ifaddr *)ptr;
>  	struct sctp_sockaddr_entry *addr;
> --- linux-2.6.20-rc1-mm1/include/net/sctp/sctp.h.old	2006-12-16 01:05:47.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/include/net/sctp/sctp.h	2006-12-16 01:05:53.000000000 +0100
> @@ -128,8 +128,6 @@
>  				     int flags);
>  extern struct sctp_pf *sctp_get_pf_specific(sa_family_t family);
>  extern int sctp_register_pf(struct sctp_pf *, sa_family_t);
> -int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
> -                        void *ptr);
>
>  /*
>   * sctp/socket.c
> --- linux-2.6.20-rc1-mm1/net/sctp/protocol.c.old	2006-12-16 01:05:59.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/net/sctp/protocol.c	2006-12-16 01:06:07.000000000 +0100
> @@ -601,8 +601,8 @@
>  }
>
>  /* Event handler for inet address addition/deletion events.  */
> -int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
> -                        void *ptr)
> +static int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
> +			       void *ptr)
>  {
>  	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
>  	struct sctp_sockaddr_entry *addr;
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


