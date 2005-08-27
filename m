Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbVH0M6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbVH0M6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbVH0M6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:58:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751505AbVH0M6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:58:16 -0400
Subject: Re: Linux 2.6 context switching and posix threads performance
	question
From: Arjan van de Ven <arjan@infradead.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050827121158.GA18406@oepkgtn.mshome.net>
References: <20050827121158.GA18406@oepkgtn.mshome.net>
Content-Type: text/plain
Date: Sat, 27 Aug 2005 14:58:09 +0200
Message-Id: <1125147489.7756.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

>  I'm asking for some kind of an authoritative answer
> quite urgently. What is the optimum thread amount on 2 CPU SMP system
> running Linux ?

context switching in linux isn't THAT expensive compared to some other
operating systems, but it's not free either.
The optimum is obviously 2 threads, one for each cpu that processes your
network service in a state machine like way. This is why thttpd beats
apache by 10x if not more.


