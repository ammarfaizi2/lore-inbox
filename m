Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVA0Vxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVA0Vxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVA0Vxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:53:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:63249 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261211AbVA0Vx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:53:28 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <41F95F79.6080904@comcast.net>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
	 <41F95F79.6080904@comcast.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 22:53:21 +0100
Message-Id: <1106862801.5624.145.camel@laptopd505.fenrus.org>
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


> I feel the need to point something out here.
> 
> [TEXT][BRK][MMAP---------------][STACK]
> 
> Here's a normal layout.
> 
> [TEXT][BRK][MMAP-------][STACK][MMAP--]
> 
> Is this one any worse?

yes.

oracle, db2 and similar like to mmap 2Gb or more *in one chunk*.
moving the stack in the middle means the biggest chunk they can mmap
shrinks. 


