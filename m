Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVGYHBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVGYHBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVGYG7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:59:21 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62357 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261687AbVGYFyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:54:22 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.11-rc5 and 2.6.12: cannot transmit anything
Date: Mon, 25 Jul 2005 08:53:29 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
References: <200507242125.36082.vda@ilport.com.ua> <20050724.222843.19810915.davem@davemloft.net>
In-Reply-To: <20050724.222843.19810915.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507250853.29586.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 July 2005 08:28, David S. Miller wrote:
>
> Probably your link is never coming up.  We won't send packets
> over the wire unless the device is in the link-up state.
>
> However, if ->dequeue() is returning NULL, there really aren't
> any packets in the device queue to be sent.
>
> If you want, add more tracing to pfifo_fast_dequeue() since
> that's almost certainly which queueing discipline is hooked
> up to your VIA Rhine device as it's the default.

Will do.
--
vda

