Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVJFTXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVJFTXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVJFTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:23:16 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:16033 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751316AbVJFTXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=0AKPUXf6JQjA8bFycCfsvaZOkGaB5WBIvFt4kILVT59kJ/noQ45f5kffnp3rC14/GzAqdRcssch6H0H6TUuLGvGWq0pvmgAYHjDMDhb3kdWz5ji+Ut2ImA/OSZYRkj6tGY3/IoIU81+Yrna2gq6x92m30+HQnYGxhj63y5FU9Bc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: PTRACE_SYSEMU numbering
Date: Thu, 6 Oct 2005 21:23:30 +0200
User-Agent: KMail/1.8.2
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>, linux-kernel@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <20050921172550.GA10332@nevyn.them.org> <200509222146.39172.blaisorblade@yahoo.it> <20050923151017.GA2558@nevyn.them.org>
In-Reply-To: <20050923151017.GA2558@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510062123.31525.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 17:10, Daniel Jacobowitz wrote:
> On Thu, Sep 22, 2005 at 09:46:38PM +0200, Blaisorblade wrote:
> > The fix is easy, IMHO, and not even urgent. It suffices to move
> > PTRACE_SYSEMU def from <linux/ptrace.h> to <asm-i386/ptrace.h>, and we
> > didn't do that yet for laziness only. There's no architecture that I know
> > of, apart i386, which implements SYSEMU (except maybe s390, but that
> > isn't public).

> Please either renumber it to something above 0x4200,

> or make it i386 
> private.
I'm going to do this.
> If you intend for other architectures to implement it in the 
> future, renumbering it would be better.
Possibly yes, sooner or later ports will emerge, but this is already in 
production, so I have ABI issues.

For new archs, I'll use the right range.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
