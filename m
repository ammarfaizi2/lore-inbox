Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWBYObE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWBYObE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWBYObE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:31:04 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:18148 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030253AbWBYObC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:31:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dBlQ9ad3gmn/nuEB1FznJYbhppy6DoXU5sXyErYELAuhsOW7SD4XD2OCYqa7003GI7pH2EECpmNzc+Y4vtU9yTcY5vw+HyA+CRxQZHHBmMcUx1g90f9xCn21tnoGp7j6QYyIb2vEz1Ui2PARuLCNDrafYF6PD2CbM8/BjzDFMAo=
Message-ID: <39e6f6c70602250631kef5adb7r7e0558733b9d2c9d@mail.gmail.com>
Date: Sat, 25 Feb 2006 11:31:01 -0300
From: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [-mm patch] net/dccp/ipv4.c: make struct dccp_v4_prot static
Cc: "Andrew Morton" <akpm@osdl.org>, davem@davemloft.net,
       acme@conectiva.com.br, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060225132729.GP3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	 <20060225132729.GP3674@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc4-mm1:
> >...
> >  git-net.patch
> >...
> >  git trees.
> >...
>
>
> There's no reason for struct dccp_v4_prot being global.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.16-rc4-mm2-full/net/dccp/ipv4.c.old       2006-02-25 04:32:45.000000000 +0100
> +++ linux-2.6.16-rc4-mm2-full/net/dccp/ipv4.c   2006-02-25 04:32:53.000000000 +0100
> @@ -1022,7 +1022,7 @@
>         .twsk_obj_size  = sizeof(struct inet_timewait_sock),
>  };
>
> -struct proto dccp_v4_prot = {
> +static struct proto dccp_v4_prot = {
>         .name                   = "DCCP",
>         .owner                  = THIS_MODULE,
>         .close                  = dccp_close,

Heck, the last series of patches were exactly to separate ipv4/ipv6 in
DCCP more clearly, how could I forget the cherry on top (sticking this static
in front of dccp_v4_prot)?

Eagle eyes indeed.

Thanks.

- Arnaldo
