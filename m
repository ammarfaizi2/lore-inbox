Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbULTIif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbULTIif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbULTHxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:53:50 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:65028 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261471AbULTG6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:58:33 -0500
Date: Mon, 20 Dec 2004 15:58:36 +0900 (JST)
Message-Id: <20041220.155836.75677852.yoshfuji@linux-ipv6.org>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][v4][19/24] Add IPoIB (IP-over-InfiniBand) driver
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200412192215.fZX1ZQqQD4QGkKcF@topspin.com>
References: <200412192215.69tnzAhGIT1vQGLF@topspin.com>
	<200412192215.fZX1ZQqQD4QGkKcF@topspin.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200412192215.fZX1ZQqQD4QGkKcF@topspin.com> (at Sun, 19 Dec 2004 22:15:14 -0800), Roland Dreier <roland@topspin.com> says:

> +enum {
> +	IPOIB_PACKET_SIZE         = 2048,
> +	IPOIB_BUF_SIZE 		  = IPOIB_PACKET_SIZE + IB_GRH_BYTES,
> +
> +	IPOIB_ENCAP_LEN 	  = 4,
> +
> +	IPOIB_RX_RING_SIZE 	  = 128,
> +	IPOIB_TX_RING_SIZE 	  = 64,
> +
> +	IPOIB_NUM_WC 		  = 4,
> +
> +	IPOIB_MAX_PATH_REC_QUEUE  = 3,
> +	IPOIB_MAX_MCAST_QUEUE     = 3,

above entries does not seem to appropriate for enum (than #define).


> +
> +	IPOIB_FLAG_OPER_UP 	  = 0,
> +	IPOIB_FLAG_ADMIN_UP 	  = 1,
> +	IPOIB_PKEY_ASSIGNED 	  = 2,
> +	IPOIB_PKEY_STOP 	  = 3,
> +	IPOIB_FLAG_SUBINTERFACE   = 4,
> +	IPOIB_MCAST_RUN 	  = 5,
> +	IPOIB_STOP_REAPER         = 6,

this seems ok, but are "xxx_FLAG_xxx" entries really flags?

> +	IPOIB_MAX_BACKOFF_SECONDS = 16,

ditto, w/ first one.

> +	IPOIB_MCAST_FLAG_FOUND 	  = 0,	/* used in set_multicast_list */
> +	IPOIB_MCAST_FLAG_SENDONLY = 1,
> +	IPOIB_MCAST_FLAG_BUSY 	  = 2,	/* joining or already joined */
> +	IPOIB_MCAST_FLAG_ATTACHED = 3,

seems fine, but are these really flags?

--yoshfuji
