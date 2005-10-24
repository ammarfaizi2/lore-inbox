Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVJXSff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVJXSff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVJXSff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:35:35 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:9091 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751242AbVJXSfe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:35:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=btiHvAY1n9b3v6MLQ60kJ5bMb6v+DNz4s9SWTi5LsDAdVPT6MO+bMPLopUNOAiAMEj9kN7w+Tv4zayGOAzKybyhSlqqbWB/ONugHIXY4Ls/7zo3JsRP/4ta37M5BjTTckeAIJe8maKlaZomvPJJAhSjVrKtszEcrOoaBHe2at+c=
Message-ID: <39e6f6c70510241135p18b018bo896b3565fa5ce87b@mail.gmail.com>
Date: Mon, 24 Oct 2005 16:35:33 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: =?ISO-2022-JP?Q?YOSHIFUJI_Hideaki_/_=1B=24B5HF=231QL=40=1B=28B?= 
	<yoshfuji@linux-ipv6.org>,
       Yan Zheng <yanzheng@21cn.com>
Subject: Re: [PATCH]IPv6: fix refcnt of struct ip6_flowlabel
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <435CCF7B.6030907@21cn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <435CCF7B.6030907@21cn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/05, Yan Zheng <yanzheng@21cn.com> wrote:
> Signed-off-by: Yan Zheng <yanzheng@21cn.com>
>
>
> Index: net/ipv6/ip6_flowlabel.c
> ===================================================================
> --- linux-2.6.14-rc5/net/ipv6/ip6_flowlabel.c   2005-10-22 10:31:13.000000000 +0800
> +++ linux/net/ipv6/ip6_flowlabel.c      2005-10-24 19:55:23.000000000 +0800
> @@ -483,7 +483,7 @@
>                                                 goto done;
>                                         }
>                                         fl1 = sfl->fl;
> -                                       atomic_inc(&fl->users);
> +                                       atomic_inc(&fl1->users);
>                                         break;

Looks OK to me, Yoshifuji-san, ACK?

- Arnaldo
