Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVAPVkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVAPVkq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVAPVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:40:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:36357 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262615AbVAPVkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:40:42 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, karim@opersys.com, hch@infradead.org,
       tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <16874.54187.919814.272833@kix.watson.ibm.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105740276.8604.83.camel@tglx.tec.linutronix.de>
	 <41E85123.7080005@opersys.com> <20050116162127.GC26144@infradead.org>
	 <41EAC560.30202@opersys.com> <16874.50688.68959.36156@kix.watson.ibm.com>
	 <20050116123212.1b22495b.akpm@osdl.org>
	 <16874.54187.919814.272833@kix.watson.ibm.com>
Content-Type: text/plain
Date: Sun, 16 Jan 2005 22:40:24 +0100
Message-Id: <1105911624.8734.55.camel@laptopd505.fenrus.org>
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

On Sun, 2005-01-16 at 16:06 -0500, Robert Wisniewski wrote:

> :-) - as above.  Furthermore, it seems that reducing the places where
> interrupts are disabled would be a good thing?  

depends at the price. On several cpus, disabling interupts is hundreds
of times cheaper than doing an atomic op. 

