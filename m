Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbULaHAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbULaHAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 02:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbULaHAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 02:00:06 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:27764 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261736AbULaHAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 02:00:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fxk0LDIBgJBwJFD1gbSBri2fn1en20cMdL5IzVEoFLZy1bhFf5wJuhEWp8guZiJLuaiz1eKR7qUHbFayTcZ2sN+AXwoLLvmm//3TZqguQKLJamNe1izTQAsRw/2pXH312DRhZD1veWNQyTOY11Ugj2OmH7xNHZb+0qolgzLv5VA=
Message-ID: <5304685704123023007441a4c3@mail.gmail.com>
Date: Fri, 31 Dec 2004 00:00:01 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Daniel Jacobowitz <dan@debian.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
	 <53046857041230112742acccbe@mail.gmail.com>
	 <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
	 <20041230230046.GA14843@nevyn.them.org>
	 <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org>
	 <20041231053618.GA25850@nevyn.them.org>
	 <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 21:47:42 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
>
> 
> 
> So I looked at just sharing the code with the debug trap handler, and the
> result is appended. strace works, as does all the TF tests I've thrown at
> it, and the code actually looks better anyway (the old do_debug code looks
> like it got the EIP wrong in VM86 mode, for example, this just cleans
> that up too). Just use a common "send_sigtrap()" routine.
> 
> Does this look saner?
> 


Yeah.  I've tested and this one works.  I don't have any other copy
protection schemes that are broken.  Of the cd-rom based, older
safedisc still worked, and the newer one needs a special device driver
that wine cannot load properly yet.  It's more likely if there is a
problem with one that it's a problem with wine at this point.

Jesse
