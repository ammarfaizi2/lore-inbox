Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292904AbSBVSnY>; Fri, 22 Feb 2002 13:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292909AbSBVSnN>; Fri, 22 Feb 2002 13:43:13 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:63440 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292904AbSBVSm5>;
	Fri, 22 Feb 2002 13:42:57 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15478.37161.767510.748999@napali.hpl.hp.com>
Date: Fri, 22 Feb 2002 10:42:49 -0800
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Steffen Persvold <sp@scali.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
In-Reply-To: <20020222111756.A11081@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org>
	<20020220103539.B32211@vger.timpanogas.org>
	<3C73DC34.E83CCD35@mandrakesoft.com>
	<20020220.093034.112623671.davem@redhat.com>
	<20020220110004.A32431@vger.timpanogas.org>
	<20020220145449.A1102@vger.timpanogas.org>
	<20020220151053.A1198@vger.timpanogas.org>
	<3C7626A9.330A9249@scali.com>
	<20020222111756.A11081@vger.timpanogas.org>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 22 Feb 2002 11:17:56 -0700, "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> said:

  Jeff> On early IA64 long long was assumed to be 64 bit, long 32
  Jeff> bit. After emailing some folks off line I relaize this may not
  Jeff> be the case any longer, but still is on some compiler options.

In the context of Linux, this is certainly not true.  Linux/ia64
always has been LP64 (i.e., sizeof(long)=8).  Perhaps you're confusing
this with the hp-ux C compiler, which defaults to ILP32?  Another
potential source of confusion is Windows, which uses the P64 data
model (only pointers and "long long" are 64 bits).

	--david
