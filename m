Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131954AbRAWXQM>; Tue, 23 Jan 2001 18:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRAWXQF>; Tue, 23 Jan 2001 18:16:05 -0500
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:13295 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S131614AbRAWXPr>; Tue, 23 Jan 2001 18:15:47 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B747797188095D@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: hiren_mehta@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: stripping symbols from modules 
Date: Tue, 23 Jan 2001 16:15:24 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is what I was guessing. But insmod does not need all symbols
present in the .o. 

I need to do this because when I release the driver to the customer,
I don't want them to be aware of some of the symbols. I understand
that this is against the open source policy. But that's how it is
and it is beyond my control. Is there any way to export only
selected symbols as required by insmod ? As of now I am not worried
about ksymoops.

Thanks and regards,
-hiren

> -----Original Message-----
> From: Keith Owens [mailto:kaos@ocs.com.au]
> Sent: Tuesday, January 23, 2001 3:06 PM
> To: MEHTA,HIREN (A-SanJose,ex1)
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: stripping symbols from modules 
> 
> 
> On Tue, 23 Jan 2001 17:34:15 -0500, 
> "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com> wrote:
> >Is there any way to strip symbols from modules .o files ?
> 
> Not safely.  Some symbols must be kept to assist insmod and hot
> plugging, strip does not know about these special symbols.
> 
> Why do you need to strip modules anyway?  I don't see the point unless
> you are critically low on disk space.  Stripping the symbols makes it
> much harder to debug oops in modules, ksymoops needs all the symbols.
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
