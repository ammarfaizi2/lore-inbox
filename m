Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVA2IF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVA2IF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVA2IF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:05:58 -0500
Received: from canuck.infradead.org ([205.233.218.70]:61710 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262875AbVA2IFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:05:51 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Arjan van de Ven <arjan@infradead.org>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com,
       Hank Leininger <hlein@progressive-comp.com>
In-Reply-To: <1106950369.3864.45.camel@localhost.localdomain>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	 <1106937110.3864.5.camel@localhost.localdomain>
	 <20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	 <1106944492.3864.30.camel@localhost.localdomain>
	 <1106945266.7776.41.camel@laptopd505.fenrus.org>
	 <1106950369.3864.45.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Jan 2005 09:05:44 +0100
Message-Id: <1106985945.4174.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
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

On Fri, 2005-01-28 at 23:12 +0100, Lorenzo Hernández García-Hierro
wrote:
> El vie, 28-01-2005 a las 21:47 +0100, Arjan van de Ven escribió:
> > as for obsd_get_random_long().. would it be possible to use the
> > get_random_int() function from the patches I posted the other day? They
> > use the existing random.c infrastructure instead of making a copy...
> 
> As seen at
>  the functions at obsd_rand.c so we wouldn't need to add more maintenance overhead, I hope you can understand why I want it like that

I actually DON'T understand that. 
What you say kinda sorta makes sense if you're an external patch. But if
you are inside the kernel (that was the goal of this patch, right?) then
the argument is actually entirely the wrong way around...

