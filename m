Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265225AbSKDMos>; Mon, 4 Nov 2002 07:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265632AbSKDMos>; Mon, 4 Nov 2002 07:44:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33031 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265225AbSKDMor>; Mon, 4 Nov 2002 07:44:47 -0500
Date: Mon, 4 Nov 2002 12:51:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: linux/bug.h and asm/bug.h
Message-ID: <20021104125115.A15953@flint.arm.linux.org.uk>
Mail-Followup-To: Ralf Baechle <ralf@uni-koblenz.de>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20021104022350.DB97A2C0C0@lists.samba.org> <20021104134148.B19377@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104134148.B19377@bacchus.dhis.org>; from ralf@uni-koblenz.de on Mon, Nov 04, 2002 at 01:41:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 01:41:48PM +0100, Ralf Baechle wrote:
> On Mon, Nov 04, 2002 at 01:22:45PM +1100, Rusty Russell wrote:
> > As the number of bug-related macros grows, this makes sense.
> > 
> > 1) Introduce linux/bug.h and #include it from linux/kernel.h so noone
> >    breaks.
> > 2) Move BUG() macro from asm*/page.h to asm*/bug.h, and #include it.
> 
> Great, people were talking about the mess caused by this just last night.
> Just one request, move the BUG_ON definition into <asm/bug.h> also.  This
> permits the use of conditional trap instructions for those architecture
> that have them.

I'm a little peeved since everyone's likes this from Rusty, but ignored
exactly the same thing from me.  Sigh, life is cruel some times.

Message-Id: E18289f-0007tm-00@flint.arm.linux.org.uk
Subject: [PATCH] 2.5.43-bug
Date: Thu, 17 Oct 2002 11:45:27 +0100

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

