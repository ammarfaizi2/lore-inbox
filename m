Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVAKHqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVAKHqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVAKHoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:44:07 -0500
Received: from canuck.infradead.org ([205.233.218.70]:24582 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262498AbVAKHms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:42:48 -0500
Subject: Re: address space reservation functionality?
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E2EB09.5000603@sbcglobal.net>
References: <41E2EB09.5000603@sbcglobal.net>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 08:42:42 +0100
Message-Id: <1105429362.3917.2.camel@laptopd505.fenrus.org>
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

On Mon, 2005-01-10 at 15:52 -0500, Robert W. Fuller wrote:
> Hi,
> 
> I was wondering if some functionality existed in Linux.  Specifically, 
> in Solaris, you can mmap the null device in order to reserve part of the 
> address space without otherwise consuming resources.  This is detailed 
> in the Solaris manpage null(7D).  The same functionality is also 
> available under Windows NT/XP/2K by calling the VirtualAlloc function 
> with the MEM_RESERVE flag omitting the MEM_COMMIT flag.  Does Linux have 
> a similar mechanism buried somewhere whereby I can reserve a part of the 
> address space and not increase the "virtual size" of the process or the 
> system's idea of the amount of memory in use?  I could not find one by 
> using the source.

malloc() already does this...
what you describe is the default behavior of linux; only when you
actually write to the memory does it get backed by ram.

