Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbVJXN1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbVJXN1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVJXN1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:27:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27035 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751017AbVJXN1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:27:42 -0400
Subject: Re: select() for delay.
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: madhu.subbaiah@wipro.com, linux-kernel@vger.kernel.org
In-Reply-To: <1130159934.7804.15.camel@localhost.localdomain>
References: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
	 <1130159934.7804.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 15:27:30 +0200
Message-Id: <1130160451.2775.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 09:18 -0400, Steven Rostedt wrote:
> Hi Maduhu,
> 
> On Mon, 2005-10-24 at 16:25 +0530, madhu.subbaiah@wipro.com wrote:
> 
> > +                        put_user(sec, &tvp->tv_sec);
> > +                        put_user(usec, &tvp->tv_usec);
> 
> I won't comment on the rest of the patch, but this part is definitely
> wrong.  The pointer tvp is a user space address and once you dereference
> that pointer to get to tv_sec, you can have a fault, which might
> segfault the

&pointer->member  doesn't dereference the pointer, it just adds the
offset of "member" to the content of the pointer.


