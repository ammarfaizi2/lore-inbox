Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129576AbRB0Qno>; Tue, 27 Feb 2001 11:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129577AbRB0Qnf>; Tue, 27 Feb 2001 11:43:35 -0500
Received: from mail.surgient.com ([63.118.236.3]:40205 "EHLO
	bignorse.SURGIENT.COM") by vger.kernel.org with ESMTP
	id <S129576AbRB0QnZ>; Tue, 27 Feb 2001 11:43:25 -0500
Message-ID: <A490B2C9C629944E85CE1F394138AF957FC3E1@bignorse.SURGIENT.COM>
From: "Collins, Tom" <Tom.Collins@Surgient.com>
To: linux-kernel@vger.kernel.org
Subject: Dynamically altering code segments
Date: Tue, 27 Feb 2001 10:43:02 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

This is my first post, so if this is off topic for this list, please direct
me
to another one that is more appropriate.  Thanks

That said, I am wanting to dynamically modify the kernel in specific places
to
implement a custom kernel trace mechanism.  The general idea is that, when
the
"trace" is off, there are NOP instruction sequences at various places in the
kernel.  When the "trace" is turned on, those same NOPs are replaced by JMPs
to code that implements the trace (such as logging events, using the MSR and
PMC's etc..).

This was a trick that was done in my old days of OS/2 performance tools 
developement to get trace information from the running kernel.  In that
case, 
we simply remapped the appropriate code segments to data segments (I think
back then it was called 'aliasing code segments') and used that segment to 
make changes to the kernel code on the fly.

Is it possible to do the same thing in Linux?

Thanks

Tom


