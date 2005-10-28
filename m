Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbVJ1RSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbVJ1RSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 13:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbVJ1RSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 13:18:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:46720 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751646AbVJ1RSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 13:18:37 -0400
In-Reply-To: <43624B98.6010405@21cn.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netdev-owner@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATH] [MCAST] IPv6: Fix algorithm to compute Querier's Query Interval
 and Maximum Response Delay
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF7FABC1EE.FDB8A0D4-ON882570A8.005EDBB4-882570A8.005F14D9@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Fri, 28 Oct 2005 10:18:47 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 10/28/2005 11:18:48,
	Serialize complete at 10/28/2005 11:18:48
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I think you're correct.

Acked-by: David L Stevens <dlstevens@us.ibm.com>
> 
> Signed-off-by: Yan Zheng <yanzheng@21cn.com>
> 
> Index: net/ipv6/mcast.c
> ===================================================================
> --- linux-2.6.14/net/ipv6/mcast.c   2005-10-28 08:02:08.000000000 +0800
> +++ linux/net/ipv6/mcast.c   2005-10-28 23:41:18.000000000 +0800
> @@ -164,7 +164,7 @@
>  #define MLDV2_MASK(value, nb) ((nb)>=32 ? (value) : ((1<<(nb))-1) & 
(value))
>  #define MLDV2_EXP(thresh, nbmant, nbexp, value) \
>     ((value) < (thresh) ? (value) : \
> -   ((MLDV2_MASK(value, nbmant) | (1<<(nbmant+nbexp))) << \
> +   ((MLDV2_MASK(value, nbmant) | (1<<(nbmant))) << \
>     (MLDV2_MASK((value) >> (nbmant), nbexp) + (nbexp))))
> 
>  #define MLDV2_QQIC(value) MLDV2_EXP(0x80, 4, 3, value)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

