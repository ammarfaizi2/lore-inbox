Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSG3REd>; Tue, 30 Jul 2002 13:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSG3REd>; Tue, 30 Jul 2002 13:04:33 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:4104 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S318352AbSG3REa>; Tue, 30 Jul 2002 13:04:30 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7915@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: rwhite@pobox.com, "'Stevie O'" <stevie@qrpff.net>
Cc: Russell King <rmk@arm.linux.org.uk>, Ed Vance <EdV@macrolink.com>,
       "'Theodore Tso'" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: RE: n_tty.c driver patch (semantic and performance correction) (a
	 ll recent versions)
Date: Tue, 30 Jul 2002 10:07:51 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, July 27, 2002 at 8:02 PM, stevie@qrpff.net wrote:
> 
> But... but... the standard says...
> 
>    A pending read shall not be satisfied until MIN bytes are 
>    received (that is, the pending read shall block until MIN 
>    bytes are received), or a signal is received.
> 
> And because I'm too dead-set on doing it that way solely because 
> that's how it's always been done, I won't ever consider changing it.  
> I'll blindly ignore how much xmodem transfers suck, and the fact 
> that I can come up with no practical purpose at all for this feature, 
> and just repeat what the standard says.  Why should we obey what 
> Linux man pages say? What do the Linux man pages have to do with 
> Linux?
> 
> Remember: Computers and their programs aren't here to make our lives 
> easier, or to make tasks simpler. They are here to follow standards.

Hi Rob, 

Stevie O gets to the central issue here. Why _not_ change long-existing,
widely used interfaces in subtle ways because the old way makes no sense to
us and the new way does? Is standards-based programming a lemming behavior? 

My answer is that but-I-think-it-would-be-better, alone, is not a sufficient
reason to risk exposure of old application bugs (if you don't actually have
to) and to bring down apps that ran just fine with the bugs for years. In
this case, the proposed new functionality is triggered by use of interface
space that already had a specified behavior. 

When new functionality is added, at a minimum, its interface should be
outside of the previous valid use set. If one simply must attach the
tendrils of cleverness to the vines of an existing interface, the new
functionality should only appear upon app behaviors that would previously
have been invalid enough to reject the request and burp up an error code. 

As I said before, innovation is fine. Just don't pollute the existing
interfaces. If even one real customer running real work has bad day because
of exposure of an old app bug or an unanticipated consequence of the change,
then it wasn't worth ignoring safer implementation practices. One can't
attain 100% safety, but one _can_ minimize the risk. 

Best regards,
Ed 

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
