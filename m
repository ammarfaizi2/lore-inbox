Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSAIU1E>; Wed, 9 Jan 2002 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSAIU0y>; Wed, 9 Jan 2002 15:26:54 -0500
Received: from mail.myrio.com ([63.109.146.2]:48628 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S289004AbSAIU0m> convert rfc822-to-8bit;
	Wed, 9 Jan 2002 15:26:42 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: initramfs programs (was [RFC] klibc requirements)
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Wed, 9 Jan 2002 12:25:37 -0800
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB23@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: initramfs programs (was [RFC] klibc requirements)
Thread-Index: AcGZOJH+IDY7PdD0TbiLosFb9+Jo5AACKSrg
From: "Torrey Hoffman" <torrey.hoffman@myrio.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <andersen@codepoet.org>, "Greg KH" <greg@kroah.com>,
        <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Jan 09, 2002 at 09:54:28AM -0800, Torrey Hoffman wrote:
> 
> > The interesting thing that I currently do with initrd support is a
> > custom network-booted Linux installer for an embedded system. 
> > 
> > I'd like to be able to do this with initramfs too.  It needs:
> [snip]
> 
> Er, for this particular application, why would you use klibc, if
> existant?  The initramfs stuff could work with glibc, if you 
> didn't mind
> a big enough image, it sounds like.

You are correct, the size of glibc is not a major problem for me right 
now and that's what I'm using.  However, it is the largest thing in my
initrd, which goes across the net using tftp, and glibc just keeps 
getting bigger...  I'm thinking of switching to ulibc when I get time.

One of the neat things about moving a lot of this formerly in-kernel
boot stuff to userspace is that it will be easier to do interesting
customization of the boot process, without having to hack the kernel.

I'm sure that this will be used in lots of innovative ways that people
haven't even thought of yet.  

So, I guess what I'd like to see with the initramfs build system is a 
easy way to build little apps like sfdisk and mkreiserfs against the 
libc it (normally) uses and add them to the ramdisk.

I'm not so worried for myself, but for an overworked sysadmin trying 
to customize the boot it could end up being very confusing... 

Torrey
