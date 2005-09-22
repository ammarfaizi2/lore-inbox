Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVIVTsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVIVTsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVIVTsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:48:31 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:8075 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030273AbVIVTsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:48:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=E9nSnSBEccxeae7U9Z/PWWRK4JA+SpcKE4ZEu27FObBZAtcgjJZJO5j20qgvNO4q8ffkmYaMOC/qmd56JqVBeWr2go4UPI+uYyaLPnlQexolU2kICqOWF5LBxO2qCd8hnyZK1hBn/trH0J3q6i6Yp++rLOB80SWkU0q8VPu1mQs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Subject: Re: PTRACE_SYSEMU numbering
Date: Thu, 22 Sep 2005 21:46:38 +0200
User-Agent: KMail/1.8.2
Cc: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <20050921172550.GA10332@nevyn.them.org> <4D3DE86B-EDE9-494E-A935-A6CE9CFF1134@wanadoo.fr>
In-Reply-To: <4D3DE86B-EDE9-494E-A935-A6CE9CFF1134@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509222146.39172.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 08:48, Laurent Vivier wrote:
> Hi,

> Paolo, as you are the submitter of the patch to the list and the real
> maintainer, what do you think about that ?

> Regards,
> Laurent

> > +#define PTRACE_SYSEMU 31

> >  /* 0x4200-0x4300 are reserved for architecture-independent
> > additions. */
> >  #define PTRACE_SETOPTIONS 0x4200

> > OK, I admit I could have made the comment clearer.
That's not your fault, the patch was born using those numbers, even because it 
started from 2.4.

> > But can we fix 
> > this?

> > You've added PTRACE_SYSEMU on top of PTRACE_GETFDPIC,
Ok, I see the value on frv.
> > which 
> > presumably will
> > mess up either debugging or UML on that architecture

> > (if the latter 
> > were
> > ported).
The fix is easy, IMHO, and not even urgent. It suffices to move PTRACE_SYSEMU 
def from <linux/ptrace.h> to <asm-i386/ptrace.h>, and we didn't do that yet 
for laziness only. There's no architecture that I know of, apart i386, which 
implements SYSEMU (except maybe s390, but that isn't public).
> > That's exactly the problem we defined the 0x4200-0x4300 
> > range
> > to prevent.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
