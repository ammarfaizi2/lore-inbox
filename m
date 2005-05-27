Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVE0KRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVE0KRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVE0KRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:17:35 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:16804
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262420AbVE0KRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:17:21 -0400
Subject: Re: RT patch acceptance
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <4296D785.2050600@yahoo.com.au>
References: <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de>  <4296ADE9.50805@yahoo.com.au>
	 <1117178430.6138.16.camel@sdietrich-xp.vilm.net>
	 <4296D785.2050600@yahoo.com.au>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 27 May 2005 12:17:40 +0200
Message-Id: <1117189060.6736.460.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 18:17 +1000, Nick Piggin wrote:
> >>Or have I missed something completely? You RT guys have thought about
> >>it - so what are some pros of the Linux-RT patch and/or cons of the
> >>nanokernel approach, please?
>
> I never saw it happen in this forum. I believe you if you say it
> has, but I suspect a lot has changed since then.

It happened and mostly ended with a flame feast.

I try to give a very short and incomplete answer to a complex question.

Having RT features integrated in the kernel itself makes it simple to do
smooth transitions of applications from the soft-RT to the hard-RT world
without changing code, recompiling. You have one set of libraries
instead of two and perfect collocation of non-RT and RT threads. Users
have only to deal with one API instead of two.

Nanokernels give you slightly better latencies and make a clear
seperation between the RT and non RT world. This seperation is better
reviewable and gives you a chance to do static code path analysis in
order to do theoretical worst case estimation, which is a prerequisite
for approvals in certain application fields.

Theres a lot more - factual and "religious", but it takes more than a
few lines and a few minutes :)

I think there will be more application areas than the unpopular
industrial/embedded stuff in the near future which would benefit from
integrated RT enhancements.


tglx


