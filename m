Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVA0UDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVA0UDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVA0UDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:03:30 -0500
Received: from canuck.infradead.org ([205.233.218.70]:13070 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261169AbVA0UDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:03:05 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: John Richard Moser <nigelenki@comcast.net>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
	 <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 21:02:58 +0100
Message-Id: <1106856178.5624.128.camel@laptopd505.fenrus.org>
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

On Thu, 2005-01-27 at 14:19 -0500, linux-os wrote:
> Gentlemen,
> 
> Isn't the return address on the stack an offset in the
> code (.text) segment?
> 
> How would a random stack-pointer value help? I think you would
> need to start a program at a random offset, not the stack!
> No stack-smasher that worked would care about the value of
> the stack-pointer.

the simple stack exploit works by overflowing a buffer ON THE STACK with
a "dirty payload and then also overwriting the return address to point
back into that buffer.

(all the security guys on this list will now cringe about this over
simplification; yes reality is more complex but lets keep the
explenation simple for Richard) 

pointing back into that buffer needs the address of that buffer. That
buffer is on the stack, which is now randomized.


