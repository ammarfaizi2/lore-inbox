Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVFJQUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVFJQUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVFJQUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:20:51 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:29340 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262599AbVFJQUp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:20:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SWxwh+49O9gwO10J1XKy3j+yZvqTxrl6PI/oIcG6DECPrzfajs0DvjTdf8jZ7DZ09FgOjVfMtpLA07A8FONZhR78bdKDrifm4DbC0Ao//8Xz9xON96KdMePcTJOrcFfGO8Hh4Dbl+7ZpipZmGdGKKwq/nRggA3kWFdFBuNvefkA=
Message-ID: <d120d50005061009206d3cdb53@mail.gmail.com>
Date: Fri, 10 Jun 2005 11:20:44 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michael Tokarev <mjt@tls.msk.ru>,
       Adam Belay <ambx1@neo.rr.com>,
       matthieu castet <castet.matthieu@free.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200506101001.40980.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>
	 <42A8AFA5.3090703@tls.msk.ru>
	 <20050609221657.C14513@flint.arm.linux.org.uk>
	 <200506101001.40980.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Thursday 09 June 2005 3:16 pm, Russell King wrote:
> > The reason that 8250 first detects your ports is that they're found
> > via the legacy method which is independent of PnP.  As you correctly
> > sumise, when you unload 8250_pnp, it disables the device so when you
> > re-load 8250, it's unable to detect your ports using the legacy method.
> >
> > But the legacy method needs to continue to exist for systems which
> > don't have PnP enabled.
> 
> But shouldn't we someday move the legacy probing from 8250
> into an 8250_platform and only do it if we don't have 8250_pnp?
> 

Given how much pain PNP/ACPI probing of i8042 was causing to everyone
I'd be cautious. BIOS writers are extremely creative. Maybe ia64 only
while x86 should default to legacy probing.

-- 
Dmitry
