Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVB1OEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVB1OEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVB1ODw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:03:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37604 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261620AbVB1OCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:02:45 -0500
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
From: Arjan van de Ven <arjan@infradead.org>
To: dtor_core@ameritech.net
Cc: "colbuse@ensisun.imag.fr" <colbuse@ensisun.imag.fr>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <d120d5000502280548733724a0@mail.gmail.com>
References: <1109596437.422319158044b@webmail.imag.fr>
	 <d120d5000502280548733724a0@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 15:02:32 +0100
Message-Id: <1109599352.6298.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

\
> > >> + for(npar = NPAR-1; npar < NPAR; npar--)
> > 
> > >How many times do you want this for loop to run?
> > 
> > NPAR times :-). As I stated, npar is unsigned.
> > 
> 
> for (npar = NPAR - 1; npar >= 0; npar--)
> 
> would be more readable and may be even faster on a dumb compiler than
> your variant. Still, I'd have compiler worry about such
> micro-optimizations.

actually that goes wrong for npar unsigned...



