Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289829AbSAKBw1>; Thu, 10 Jan 2002 20:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289828AbSAKBwR>; Thu, 10 Jan 2002 20:52:17 -0500
Received: from mail.myrio.com ([63.109.146.2]:33519 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S289830AbSAKBwG> convert rfc822-to-8bit;
	Thu, 10 Jan 2002 20:52:06 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [RFC] klibc requirements, round 2
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Thu, 10 Jan 2002 17:50:52 -0800
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB2C@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] klibc requirements, round 2
Thread-Index: AcGaOac5WmRnA/34SsaQ0VgjWeZwYgABTpBg
From: "Torrey Hoffman" <torrey.hoffman@myrio.com>
To: "Tom Rini" <trini@kernel.crashing.org>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <felix-dietlibc@fefe.de>,
        <andersen@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Jan 10, 2002 at 03:18:49PM -0800, Greg KH wrote:
... 
> > 	- image viewer
> > 	- mkreiserfs
> 
> I think these are examples of misunderstanding what initramfs _can do_
> with what we (might) need a klibc to do.  
...
> These programs _might_ compile with a klibc, but I wouldn't 
> worry about
> it.  uClibc is what should be used for many of these custom 
> applications

Well, as the person who first mentioned mkreiserfs and the like,
I agree with you.  For the majority of systems out there which 
aren't using initrd now, a minimal klibc for an unmodified 
initramfs makes sense.

My concern is with the minority who are using initrd, and in
some cases a very customized initrd.  

The important thing, I think, is that it should be easy for
less-than-guru level hackers to add programs to the initramfs,
even if the program they want can't be linked with klibc.

This really comes down to: What will the build process be for
these initramfs images?

By the way, is initramfs intended to supercede initrd, or will 
they co-exist?  

Torrey
