Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVC1Sze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVC1Sze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVC1Sze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:55:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42642 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262000AbVC1SzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:55:25 -0500
Subject: Re: Collecting NX information
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, ubuntu-hardened@lists.ubuntu.com
In-Reply-To: <4248520E.1070602@comcast.net>
References: <42484B13.4060408@comcast.net>
	 <1112035059.6003.44.camel@laptopd505.fenrus.org>
	 <4248520E.1070602@comcast.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 20:55:20 +0200
Message-Id: <1112036121.6003.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Mon, 2005-03-28 at 13:50 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Arjan van de Ven wrote:
> >>As I understand, PT_GNU_STACK uses a single marking to control whether a
> >>task gets an executable stack and whether ASLR is applied to the
> >>executable.
> > 
> > 
> > you understand wrongly.
> > 
> > PT_GNU_STACK just sets the exec permission for the stack (and the heap
> > now mirrors the stack). Nothing more nothing less.
> > 
> 
> So then this would be slightly more useful than I had previously
> thought, bringing control over the randomization as well?

actually Linus was really against adding non-related things to this
flag. And I think he is right...

Now.. do you have any examples of when you want a binary marked for no-
randomisation ?? (eg something the setarch flag won't fix/won't be good
enough for)

