Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSI3BSr>; Sun, 29 Sep 2002 21:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261888AbSI3BSr>; Sun, 29 Sep 2002 21:18:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:26886 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261886AbSI3BSq>; Sun, 29 Sep 2002 21:18:46 -0400
Date: Sun, 29 Sep 2002 22:24:09 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: init ordering bug in 802/psnap.c vs llc/llc_main.c
Message-ID: <20020930012409.GI7028@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200209300121.g8U1LCS07667.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200209300121.g8U1LCS07667.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2002 at 03:21:12AM +0200, Andries.Brouwer@cwi.nl escreveu:
> > Humm, 2.5.39? It is compiled statically, isn't it?
> > I'm working exclusively with modules up to now
> 
> A good hint. llc/llc_main.c crashes in llc_sap_find()
> because llc_init() has not yet been called, so that
> llc_main_station.sap_list.list is not initialized.
> 
> And llc_sap_find() was called from 802/psnap.c, in snap_init().
> 
> Calling llc_init() and snap_init() in the right order
> makes the oops go away.

Thanks for investigating and reporting :-)

- Arnaldo
