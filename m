Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVFJHD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVFJHD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVFJHD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:03:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8902 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262235AbVFJHD5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:03:57 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [TTY] exclusive mode question
Date: Fri, 10 Jun 2005 10:03:24 +0300
User-Agent: KMail/1.5.4
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
References: <20050609121638.GD507@gilgamesh.home.res> <20050609142250.80926.qmail@web25804.mail.ukl.yahoo.com> <20050609161225.A14513@flint.arm.linux.org.uk>
In-Reply-To: <20050609161225.A14513@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506101003.24835.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 June 2005 18:12, Russell King wrote:
> On Thu, Jun 09, 2005 at 04:22:49PM +0200, moreau francis wrote:
> > --- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :
> > > Le 09/06/05 13:41 +0200, moreau francis écrivit:
> > > > 
> > > > oh ok...sorry I misunderstood TIOEXCL meaning ;)
> > > > Do you know how I could implement such exclusive mode (the one I described)
> > > ?
> > > > 
> > > This is handled through lock files, google for LCK..ttyS0
> > >
> > 
> > This lock mechanism is a convention but nothing prevent a user application to
> > issue a "echo foo > /dev/ttyS0" command while "LCK..ttyS0" file exists...
> 
> Which is absolutely necessary to work if you think about an application
> like minicom and its file transfer helpers, which may need to re-open
> the serial port.
> 
> TTY locking is done via lock files only, and all non-helper applications
> must coordinate their access via the lock files.  There is no other
> mechanism.

I think original reporter is saying that TIOEXCL is nearly useless then.
--
vda

