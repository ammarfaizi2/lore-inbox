Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSGYGRE>; Thu, 25 Jul 2002 02:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSGYGRE>; Thu, 25 Jul 2002 02:17:04 -0400
Received: from [209.237.59.50] ([209.237.59.50]:52475 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S318348AbSGYGRC>; Thu, 25 Jul 2002 02:17:02 -0400
To: Greg KH <greg@kroah.com>
Cc: Martin Brulisauer <martin@uceb.org>, linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
References: <20020723114703.GM11081@unthought.net>
	<3D3E75E9.28151.2A7FBB2@localhost> <20020725052957.GA13523@kroah.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 24 Jul 2002 23:20:10 -0700
In-Reply-To: <20020725052957.GA13523@kroah.com>
Message-ID: <52znwgib1h.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Martin> By the way: Multiline C Macros are depreached and will not
    Martin> be supported by a future version of gcc and as for today
    Martin> will generate a bunch of warnings.

    Greg> Why is this?  Is it a C99 requirement?

I'm not sure what Martin is talking about here.  I'm sure that
multiline macros are part of standard C.  The second translation phase
(immediately after character set mapping but _before_ preprocessing)
deletes any occurrences of \ followed by a newline.  The preprocessor
should not behave differently if a macro definition is broken up with \'s.

The copy of the ISO C standard that I have (the August 3, 1998 draft)
even has an example of a macro with a multiline definition in the
section on macro replacement.

I really doubt that gcc will break this standards-compliant,
extensively-used behavior.  Perhaps I misunderstood Martin but I don't
think there was anything wrong syntactically with the list macros
posted earlier.

Best,
  Roland
