Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVASS4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVASS4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVASS4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:56:15 -0500
Received: from canuck.infradead.org ([205.233.218.70]:6930 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261848AbVASS4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:56:06 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41EEA86D.7020108@comcast.net>
References: <20050112182838.2aa7eec2.akpm@osdl.org>
	 <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	 <1105635662.6031.35.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>
	 <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu>
	 <41EEA86D.7020108@comcast.net>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 19:55:43 +0100
Message-Id: <1106160943.6310.184.camel@laptopd505.fenrus.org>
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

> I respect you as a kernel developer as long as you're doing preemption
> and schedulers; but I honestly think PaX is the better technology, and I
> think it's important that the best security technology be in place.  

the difference is not that big and only in tradeoffs. eg pax trades
virtual address space against protecting a rare occurance (eg where exec
shield wouldn't work because of a high executable mapping. That really
doesn't happen in normal programs)

> On a final note, isn't PaX the only technology trying to apply NX
> protections to kernel space? 

Exec Shield does that too but only if your CPU has hardware assist for
NX (which all current AMD and most current intel cpus do).


