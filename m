Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVA1SMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVA1SMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVA1SJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:09:44 -0500
Received: from canuck.infradead.org ([205.233.218.70]:5385 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261515AbVA1SIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:08:07 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Arjan van de Ven <arjan@infradead.org>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <1106932637.3778.92.camel@localhost.localdomain>
References: <1106932637.3778.92.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Jan 2005 19:07:57 +0100
Message-Id: <1106935677.7776.29.camel@laptopd505.fenrus.org>
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

On Fri, 2005-01-28 at 18:17 +0100, Lorenzo Hernández García-Hierro
wrote:
> Hi,
> 
> Attached you can find a split up patch ported from grSecurity [1], as
> Linus commented that he wouldn't get a whole-sale patch, I was working
> on it and also studying what features of grSecurity can be implemented
> without a development or maintenance overhead, aka less-invasive
> implementations.


why did you make it a config option? This is the kind of thing that is
either good or isn't... at which point you can get rid of a lot of, if
not all the ugly ifdefs the patch adds.

Also, why does it need to enhance the random driver this much, the
random driver already has a facility to provide pseudorandom numbers
good enough for networking use (eg the PRNG rekeys often enough with
real entropy that brute forcing it shouldn't be possible).

If you can fix those 2 things the patch will look a lot cleaner and has
a lot higher chance to be merged.

