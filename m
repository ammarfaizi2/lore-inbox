Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUDER7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUDER7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:59:43 -0400
Received: from web40509.mail.yahoo.com ([66.218.78.126]:540 "HELO
	web40509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263032AbUDER7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:59:41 -0400
Message-ID: <20040405175940.94093.qmail@web40509.mail.yahoo.com>
Date: Mon, 5 Apr 2004 10:59:40 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Timothy Miller <miller@techsource.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <4071A036.4050003@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Timothy Miller <miller@techsource.com> wrote:
> 
> 
> Sergiy Lozovsky wrote:
> 
> > 
> > I put LISP interpreter inside the Kernel -
> 
> 
> 
> I'm dying to know why you need a LISP interpreter
> inside the kernel.

It is explained at my project home page -
http://vxe.quercitron.com

Basically there are two reasons.

1. Give system administrator possibility to change
security policy easy enough without C programminig
inside the kernel (we should not expect system
administartor to be a kernel guru). Language of higher
lavel make code more compact (C - is too low level,
that's why people use PERL for example or LISP). Lisp
was chosen because of very compact VM - around 100K.

2. Protect system from bugs in security policy created
by system administrator (user). LISP interpreter is a
LISP Virtual Machine (as Java VM). So all bugs are
incapsulated and don't affect kernel. Even severe bugs
in this LISP kernel module can cause termination of
user space application only (except of stack overflow
- which I can address). LISP error message will be
printed in the kernel log.

Serge.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
