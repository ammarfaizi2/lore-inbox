Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUHaHXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUHaHXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 03:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUHaHXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 03:23:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:43193 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267287AbUHaHXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 03:23:00 -0400
Date: Tue, 31 Aug 2004 09:22:59 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       tonnerre@thundrix.ch
MIME-Version: 1.0
References: <200408310604.i7V64k7o010652@magilla.sf.frob.com>
Subject: Re: [PATCH] waitid system call
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <12757.1093936979@www31.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone writing a manual page for this sys call?  If not, I will.

> The AIX results someone posted suggested that it does not clear siginfo_t
> fields on WNOHANG early returns.  

Yes.

> I still maintain that a POSIX application
> must not assume that waitid will clear any fields.  

Despite the fact that I've pushed in the direction of changing 
this, I do agree: a portable application must handle weird 
behaviours on AIX and HP-UX.  (And I would document this in 
the man page.)

> However, since the
> majority do, I see no harm in making Linux do so as well.

And I do think this is the right way to go.  Perhaps one day
the other implementations will do the Right Thing, or POSIX 
will tighten its spec to require the behavior currently 
implemented by the majority -- best then that Linux doesn't 
imitate the "broken" implementations.

Cheers,

Michael

-- 
Supergünstige DSL-Tarife + WLAN-Router für 0,- EUR*
Jetzt zu GMX wechseln und sparen http://www.gmx.net/de/go/dsl

