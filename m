Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVAUHvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVAUHvr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVAUHvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:51:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:35337 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262311AbVAUHtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:49:46 -0500
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
From: Arjan van de Ven <arjan@infradead.org>
To: george@mvista.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       matthias@corelatus.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41F03AD2.4010803@mvista.com>
References: <16872.55357.771948.196757@antilipe.corelatus.se>
	 <20050115013013.1b3af366.akpm@osdl.org>
	 <1105830384.16028.11.camel@localhost.localdomain>
	 <1105877497.8462.0.camel@laptopd505.fenrus.org>
	 <41EEF284.2010600@mvista.com>
	 <1106208433.4192.0.camel@laptopd505.fenrus.org>
	 <41F03AD2.4010803@mvista.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 08:49:28 +0100
Message-Id: <1106293769.4182.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > This one I meant to fix in the kernel fwiw; we can put that loop inside
> > the kernel easily I'm sure
> 
> Yes, but it will increase the data size of the timer...
> 

eh how?
the way I think it can be done is to just have multiple timers fire
until the total time is up. It's not a performance issue (a timer firing
every 24 days.. who cares, esp since such long delays are rare anyway)
after all...


