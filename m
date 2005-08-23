Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVHZP2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVHZP2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVHZP2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:28:38 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:23887 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965077AbVHZP2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:28:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=pxS+F7EVJ2L67ft6wOE5yNvIb+L6+iZfJ6EPIh1i1LeYc+nDvh2vsJlDaPAz85+KMaXJVv+fhZuwkE+NooBdBCs7SNlmPfciLojt2Jd8ftVSpSUUAHdcpaOfJSBtuVwVJXuHUckXleeSBB2IH1b7JEa060OpmV8ygXP+GOt3iOw=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 18/39] remap_file_pages protection support: add VM_FAULT_SIGSEGV
Date: Tue, 23 Aug 2005 10:45:46 +0200
User-Agent: KMail/1.8.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu
References: <20050812182145.DF52E24E7F3@zion.home.lan> <43006AA6.1040405@yahoo.com.au> <20050815111548.F19811@flint.arm.linux.org.uk>
In-Reply-To: <20050815111548.F19811@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231045.50500.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 August 2005 12:15, Russell King wrote:
> On Mon, Aug 15, 2005 at 08:12:54PM +1000, Nick Piggin wrote:
> > Well there is now, and that is we are now using a bit in the 2nd
> > byte as flags. So I had to do away with -ve numbers there entirely.

> > You could achieve a similar thing by using another bit in that byte
> > #define VM_FAULT_FAILED 0x20
> > and make that bit present in VM_FAULT_OOM and VM_FAULT_SIGBUS, then
> > do an unlikely test for that bit in your handler and branch away to
> > the slow path.
 
> That'll do as well, thanks.
Note that what Nick said is about mainline kernels, not only my brave patch.

Currently Linus fixed up ARM26 by disabling the optimization: see git commit 
6e346228c76506e07e297744a28464022c6806ad.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
