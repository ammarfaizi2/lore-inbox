Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbTL3QrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbTL3QrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:47:07 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:42757 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S265839AbTL3QrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:47:05 -0500
Date: Tue, 30 Dec 2003 14:57:52 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [patch] clean up tcp_sk(), 2.6.0
Message-ID: <20031230165751.GH28868@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20031230163230.GA12553@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230163230.GA12553@elte.hu>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 30, 2003 at 05:32:30PM +0100, Ingo Molnar escreveu:
> 
> i recently wasted a few hours on a bug where i used "tcp_sk(sock)"
> instead of "tcp_sk(sock->sk)" - the former, while being blatantly
> incorrect, compiles just fine on 2.6.0. The patch below is equivalent to
> the define but is also type-safe. Compiles cleanly & boots fine on
> 2.6.0.

Don't have a problem, but then it'd be nice to do this for udp_sk, raw_sk,
etc, etc :)
 
- Arnaldo
