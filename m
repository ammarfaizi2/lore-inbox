Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262917AbSJGI3C>; Mon, 7 Oct 2002 04:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262919AbSJGI3C>; Mon, 7 Oct 2002 04:29:02 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:64499 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262917AbSJGI3B>; Mon, 7 Oct 2002 04:29:01 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021002120540.D24770@flint.arm.linux.org.uk> 
References: <20021002120540.D24770@flint.arm.linux.org.uk>  <200210021257.43121.devilkin-lkml@blindguardian.org> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.50 - 8250_cs does NOT work 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Oct 2002 09:34:27 +0100
Message-ID: <18990.1033979667@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
> > If i load the 8250_cs module, I get _nothing_ at all. No text in
> > system logs, nothing. Modem doesn't respond under the old /dev/ttyS1, 
> > I've tried all other /dev/ttySx's to see if it hasn't been remapped.
> > Unfortunately, no.
> > 
> > Is there anything else I can try? I really need my modem back...

> Known problem.  I've sent a fix to someone else for it but iirc they
> never came back.  The following patch is completely untested - I'm
> still trying to get 2.5.40 to build at present. 

Doesn't compile. ALPHA_KLUDGE_MCR undefined. That crap in the generic 8250
code should go away in favour of some mask bits set by the platform-specific
code when it registers the ports. You probably want to set the default _and_
the permitted bits that way.

--
dwmw2


