Return-Path: <linux-kernel-owner+w=401wt.eu-S1752872AbWLSPsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbWLSPsI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 10:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbWLSPsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 10:48:07 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52681 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbWLSPsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 10:48:06 -0500
X-Originating-Ip: 24.163.66.209
Date: Tue, 19 Dec 2006 10:43:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Get rid of most of the remaining k*alloc() casts.
In-Reply-To: <Pine.LNX.4.61.0612191639540.10396@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0612191039190.7558@localhost.localdomain>
References: <Pine.LNX.4.64.0612190627020.22485@localhost.localdomain>
 <Pine.LNX.4.61.0612191639540.10396@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-12.252, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05,
	SARE_SUB_GETRID 0.56)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006, Jan Engelhardt wrote:

> >  Get rid of the remaining obvious pointer casts of all k[cmz]alloc
> >calls, and do a little whitespace cleanup on the result, based on the
> >CodingStyle file.
>
> >-		struct intmem_allocation* alloc =
> >-		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
> >+		struct intmem_allocation* alloc =
> >+			kmalloc(sizeof(*alloc), GFP_KERNEL);
>
> At the same time, you could make * alloc -> *alloc when it falls on
> the same line as the kmczalloc cleanup. :)

i'd actually thought of that but, as with previous patches of mine,
it's a trade-off -- the more i try to do at once, the more chance
there is of having the patch rejected for some sort of
incompatibility.

as you may have noticed, i try to write scripts to automate a lot of
this.  this last patch definitely needed more manual work than
previous patches so i was loathe to try to push the envelope -- i
wanted to concentrate on the superfluous casts this time, and leave
other issues for future, well-defined patches.

"bit by bit," that's my motto.  well, that and "life is too short to
drink bad wine."

rday
