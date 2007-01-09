Return-Path: <linux-kernel-owner+w=401wt.eu-S1751392AbXAINCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbXAINCL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbXAINCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:02:11 -0500
Received: from userg501.nifty.com ([202.248.238.81]:17947 "EHLO
	userg501.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXAINCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:02:09 -0500
DomainKey-Signature: a=rsa-sha1; s=userg501; d=nifty.com; c=simple; q=dns;
	b=pjr6FgIEhtrz2XiPzXv7tAJXi2LVyP1M7yULCO/Xu83kci9SA7M55zO5beu2A8X2s
	i8qyi+5fr5+Dq77U+mAXg==
Date: Wed, 10 Jan 2007 07:01:27 +0900
From: Komuro <komurojun-mbn@nifty.com>
To: Craig Schlenter <craig@codefountain.com>
Cc: YOSHIFUJI Hideaki / =?ISO-2022-JP?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>,
       bunk@stusta.de, jgarzik@pobox.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops during
 file-transfer
Message-Id: <20070110070127.350d6742.komurojun-mbn@nifty.com>
In-Reply-To: <20070104122330.GA2233@craigdell.detnet.com>
References: <20061230185043.d31d2104.komurojun-mbn@nifty.com>
	<20061230.102358.106876516.yoshfuji@linux-ipv6.org>
	<20061230205931.9e430173.komurojun-mbn@nifty.com>
	<20061230.231952.16573563.yoshfuji@linux-ipv6.org>
	<20070105054546.953196e5.komurojun-mbn@nifty.com>
	<20070104122330.GA2233@craigdell.detnet.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 14:23:30 +0200
Craig Schlenter <craig@codefountain.com> wrote:


> > --- linux-2.6.20-rc3/net/ipv4/tcp_ipv4.c.orig	2007-01-03 11:50:04.000000000 +0900
> > +++ linux-2.6.20-rc3/net/ipv4/tcp_ipv4.c	2007-01-03 15:30:44.000000000 +0900
> > @@ -648,7 +648,7 @@ static void tcp_v4_send_ack(struct tcp_t
> >  				   TCPOLEN_TIMESTAMP);
> >  		rep.opt[1] = htonl(tcp_time_stamp);
> >  		rep.opt[2] = htonl(ts);
> > -		arg.iov[0].iov_len = TCPOLEN_TSTAMP_ALIGNED;
> > +		arg.iov[0].iov_len = sizeof(rep);
> 
> Perhaps this was supposed to be
>                 arg.iov[0].iov_len += TCPOLEN_TSTAMP_ALIGNED;
> 
> That's what the ipv6 stuff does in places.

It works properly.
Thanks!


Best Regards
Komuro

