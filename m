Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTA1GE5>; Tue, 28 Jan 2003 01:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTA1GE5>; Tue, 28 Jan 2003 01:04:57 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31446 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261354AbTA1GE4>;
	Tue, 28 Jan 2003 01:04:56 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15926.8118.201009.321051@napali.hpl.hp.com>
Date: Mon, 27 Jan 2003 22:14:14 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: return-type for search_extable() 
In-Reply-To: <20030128055643.BCB282C236@lists.samba.org>
References: <15921.33955.645830.709868@napali.hpl.hp.com>
	<20030128055643.BCB282C236@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 28 Jan 2003 15:53:20 +1100, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> Hmm, I actually just tried to do this, and like all typedefs,
  Rusty> it's icky.  search_exception_table() belongs in kernel.h, not
  Rusty> module.h where it is now.  But that means kernel.h has to
  Rusty> include asm/uaccess.h to get exception_fixup_t.

Yeah, that is a bit ugly.

  Rusty> Maybe the cleanest way really is to simply document that your
  Rusty> search_extable() returns the fixup word... 8(

It turns out that on Dec 18th laster year, HJ Lu fixed the gas bug
that prevented me from using the place-relative relocations.  I ended
up biting the bullet and making the bleeding edge assembler a
pre-requisite for building 2.5.59.  I try to avoid that, but in this
case, it was better than the alternatives.

Anyhow, it means that we don't need a separate type anymore for ia64.

Thanks,

	--david
