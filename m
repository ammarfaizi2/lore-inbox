Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVA1Hds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVA1Hds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 02:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVA1Hds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 02:33:48 -0500
Received: from canuck.infradead.org ([205.233.218.70]:8196 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261267AbVA1Hdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 02:33:47 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: Jirka Kosina <jikos@jikos.cz>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0501272323150.9190@twin.jikos.cz>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>
	 <Pine.LNX.4.58.0501272323150.9190@twin.jikos.cz>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 08:33:39 +0100
Message-Id: <1106897619.4172.0.camel@laptopd505.fenrus.org>
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


> I thought that this was the original purpose of the "stack randomization" 
> which is shipped for example by RedHat kernels, as the randomization is 
> quite small and easy to bruteforce, so it can't serve too much as a buffer 
> overflow protection.

correct; that was for the p4 hyperthreading case (that code fwiw is
still in the 2.6 mainline kernel and active; it randomizes over an 8k
region for this purpose)

