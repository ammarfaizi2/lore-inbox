Return-Path: <linux-kernel-owner+w=401wt.eu-S1750937AbWLNTt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWLNTt7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWLNTt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:49:58 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:10198 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbWLNTt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:49:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=SaxtgueKYTBAxB0BkbE4H/jI+/pOVb7nhyvmHa6dCW8eiQQCaEGY5MxkL0ShaKpBv5IQU2LUbyRqQYjIdo1cKqhsGSNicmoCIB9uIH5PPRUps90ZSBjhypdwOloqNwWNbcc985Geku/crUtt7aDkdejdsPPZbZvS8r15eUmsDco=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Scott Preece'" <sepreece@gmail.com>, "'Chris Wedgwood'" <cw@f00f.org>
Cc: "'Eric Sandeen'" <sandeen@sandeen.net>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Jeff Garzik'" <jeff@garzik.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Martin Bligh'" <mbligh@mbligh.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Thu, 14 Dec 2006 11:49:48 -0800
Message-ID: <006e01c71fb9$05bcf970$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <7b69d1470612141142k63cc7d11l89c0a7f26acc631a@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AccfuF0djwcVzBLsQ0uLB8Xf1McniwAAI6ZA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd suggest putting a Documentation/GPL-Symbols to explain this.

Then in the "tainted" message, have a pointer to that documentation. 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Scott Preece
> Sent: Thursday, December 14, 2006 11:43 AM
> To: Chris Wedgwood
> Cc: Eric Sandeen; Christoph Hellwig; Linus Torvalds; Jeff 
> Garzik; Greg KH; Jonathan Corbet; Andrew Morton; Martin 
> Bligh; Michael K. Edwards; linux-kernel@vger.kernel.org
> Subject: Re: GPL only modules [was Re: [GIT PATCH] more 
> Driver core patches for 2.6.19]
> 
> On 12/14/06, Chris Wedgwood <cw@f00f.org> wrote:
> > On Thu, Dec 14, 2006 at 12:15:20PM -0600, Eric Sandeen wrote:
> >
> > > Please don't use that name, it strikes me as much more confusing 
> > > than EXPORT_SYMBOL_GPL, even though I agree that _GPL 
> doesn't quite 
> > > convey what it means, either.
> >
> > Calling internal symbols _INTERNAL is confusing?
> 
> I think it's the combination of "INTERNAL" and "EXPORT" that 
> seems contradictory - "If it's internal, why are you exporting it?"
> 
> I think "EXPORT_SYMBOL_GPL_ONLY" or "...ONLY UNDER_GPL" would 
> make the meaning clearer, but I don't really think the gain 
> is worth the pain.
> Anybody using kernel interfaces ought to be able to figure it out.
> 
> >
> > But those symbols aren't, they're about internal interfaces 
> that might 
> > change.
> 
> Folks who think this is likely to make a difference in court 
> might want to look at 
> <http:www.linuxworld.com/news/2006/120806-closed-modules2.html
> > for a litany of court cases that have rejected infringement 
> claims where a much sterner effort had been made to hide or 
> block use of interfaces.
> The article claims that courts have increasingly found that 
> interfacing your code to an existing work is not 
> infringement, regardless of what you have to work around to do it.
> 
> Of course, that's one author's reading of the case law and 
> I'm sure there are others who disagree, but it's something 
> you'd want to keep in mind in calculating the expected value 
> of a suit...
> 
> scott
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

