Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVFJJiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVFJJiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVFJJiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:38:07 -0400
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:27746 "HELO
	web25806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262315AbVFJJgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:36:55 -0400
Message-ID: <20050610093654.94565.qmail@web25806.mail.ukl.yahoo.com>
Date: Fri, 10 Jun 2005 11:36:54 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [TTY] exclusive mode question
To: Denis Vlasenko <vda@ilport.com.ua>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200506101003.24835.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Denis Vlasenko <vda@ilport.com.ua> a écrit :

> On Thursday 09 June 2005 18:12, Russell King wrote:
> > On Thu, Jun 09, 2005 at 04:22:49PM +0200, moreau francis wrote:
> > > --- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :
> > > > Le 09/06/05 13:41 +0200, moreau francis écrivit:
> > > > > 
> > > > > oh ok...sorry I misunderstood TIOEXCL meaning ;)
> > > > > Do you know how I could implement such exclusive mode (the one I
> described)
> > > > ?
> > > > > 
> > > > This is handled through lock files, google for LCK..ttyS0
> > > >
> > > 
> > > This lock mechanism is a convention but nothing prevent a user
> application to
> > > issue a "echo foo > /dev/ttyS0" command while "LCK..ttyS0" file exists...
> > 
> > Which is absolutely necessary to work if you think about an application
> > like minicom and its file transfer helpers, which may need to re-open
> > the serial port.
> > 
> > TTY locking is done via lock files only, and all non-helper applications
> > must coordinate their access via the lock files.  There is no other
> > mechanism.
> 
> I think original reporter is saying that TIOEXCL is nearly useless then.
>

Why not using mandatory locks instead of this "weak" user lock mechanism ?

              Francis


	
	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
