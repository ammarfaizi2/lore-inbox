Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbTAQHZT>; Fri, 17 Jan 2003 02:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTAQHZT>; Fri, 17 Jan 2003 02:25:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:63483 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267418AbTAQHZS>; Fri, 17 Jan 2003 02:25:18 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030116180913.C15981@twiddle.net> 
References: <20030116180913.C15981@twiddle.net>  <20030114171457.E5751@twiddle.net> <20030117015756.409DF2C437@lists.samba.org> 
To: Richard Henderson <rth@twiddle.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davem@vger.kernel.org
Subject: Re: [module-init-tools] fix weak symbol handling 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Jan 2003 07:34:14 +0000
Message-ID: <30299.1042788854@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rth@twiddle.net said:
> > > No.  The semantics I need is if A references a weak symbol S 
> > > and *no one* implements it, then S resolves to NULL.
> > 
> > Sorry, I was unclear.  I want to know the dependency semantics:
> 
> If B exports S, should depmod believe A needs B, or not?  Your patch
> leaves that semantic (all it does is suppress the errors).
> Well, that depends on whether A defines S or not.  If A does define S,
> then I don't care.  I'd say "no", A does not depend on B.  If A does
> not define S, then most definitely "yes", as with any other
> definition.

As long as doing so doesn't make modprobe fail to load A when B isn't 
present or refuses to load. Otherwise what was the point in making it weak?

--
dwmw2


