Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVCJXbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVCJXbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbVCJX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:26:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8359 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262362AbVCJXUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:20:34 -0500
Date: Thu, 10 Mar 2005 23:20:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [06/11] [TCP]: Put back tcp_timer_bug_msg[] symbol export.
Message-ID: <20050310232014.GA32228@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
	pekkas@netcore.fi, jmorris@redhat.com, yoshfuji@linux-ipv6.org,
	kaber@coreworks.de, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org, stable@kernel.org
References: <20050310230519.GA22112@kroah.com> <20050310230843.GG22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230843.GG22112@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/net/ipv4/tcp_timer.c	2005-03-09 17:20:38 -08:00
> +++ b/net/ipv4/tcp_timer.c	2005-03-09 17:20:38 -08:00
> @@ -38,6 +38,7 @@
>  
>  #ifdef TCP_DEBUG
>  const char tcp_timer_bug_msg[] = KERN_DEBUG "tcpbug: unknown timer value\n";
> +EXPORT_SYMBOL(tcp_timer_bug_msg);
>  #endif

not complaining about putting this into -stable, but why do people have
TCP_DEBUG turned on for normal builds?

