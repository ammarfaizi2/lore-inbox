Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVAQPu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVAQPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVAQPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:50:26 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:43419 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261869AbVAQPuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:50:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jan 2005 10:48:52 -0500 (EST)
To: Arjan van de Ven <arjan@infradead.org>
Cc: Robert Wisniewski <bob@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       karim@opersys.com, hch@infradead.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <1105911624.8734.55.camel@laptopd505.fenrus.org>
References: <20050114002352.5a038710.akpm@osdl.org>
	<1105740276.8604.83.camel@tglx.tec.linutronix.de>
	<41E85123.7080005@opersys.com>
	<20050116162127.GC26144@infradead.org>
	<41EAC560.30202@opersys.com>
	<16874.50688.68959.36156@kix.watson.ibm.com>
	<20050116123212.1b22495b.akpm@osdl.org>
	<16874.54187.919814.272833@kix.watson.ibm.com>
	<1105911624.8734.55.camel@laptopd505.fenrus.org>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16875.56543.264481.586616@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
 > On Sun, 2005-01-16 at 16:06 -0500, Robert Wisniewski wrote:
 > 
 > > :-) - as above.  Furthermore, it seems that reducing the places where
 > > interrupts are disabled would be a good thing?  
 > 
 > depends at the price. On several cpus, disabling interupts is hundreds
 > of times cheaper than doing an atomic op. 

Wow - disabling interrupts is handfuls to tens of cycles, so that means
some architectures take thousands of cycles to do atomic operations.  Then
I would definitely agree we should not be using atomic operations on those,
fwiw, out of curiosity, what archs make atomic ops so expensive.

Andrew, on the broader note.  If the community feels disabling interrupts
is the better way to go for the variables (I think it's index and count) we
were protecting with atomic ops then as the code stands things should be
fine with that approach and we can make that change.

Thanks for your attention to looking through this.

-bob

Robert Wisniewski
The K42 MP OS Project
http://www.research.ibm.com/K42/
bob@watson.ibm.com
