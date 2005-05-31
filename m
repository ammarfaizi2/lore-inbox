Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVEaOpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVEaOpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVEaOpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:45:11 -0400
Received: from isilmar.linta.de ([213.239.214.66]:56258 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261426AbVEaOpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:45:05 -0400
Date: Tue, 31 May 2005 16:45:04 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org,
       sakugawa@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc5] m32r: Update m32r_cfc.[ch] to support Mappi-III platform
Message-ID: <20050531144504.GA5783@isilmar.linta.de>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org,
	sakugawa@linux-m32r.org, linux-kernel@vger.kernel.org
References: <20050531.221702.1044949015.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531.221702.1044949015.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> @@ -825,7 +814,7 @@ static int __init init_m32r_pcc(void)
>  	for (i = 0 ; i < pcc_sockets ; i++) {
>  		socket[i].socket.dev.dev = &pcc_device.dev;
>  		socket[i].socket.ops = &pcc_operations;
> -		socket[i].socket.resource_ops = &pccard_static_ops;
> +		socket[i].socket.resource_ops = &pccard_nonstatic_ops;
>  		socket[i].socket.owner = THIS_MODULE;
>  		socket[i].number = i;
>  		ret = pcmcia_register_socket(&socket[i].socket);

Uh, are you sure?

	Dominik
