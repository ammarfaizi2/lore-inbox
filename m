Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269288AbRHGSyZ>; Tue, 7 Aug 2001 14:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269290AbRHGSyO>; Tue, 7 Aug 2001 14:54:14 -0400
Received: from mail.myrio.com ([63.109.146.2]:57589 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S269288AbRHGSyB>;
	Tue, 7 Aug 2001 14:54:01 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'David Maynor'" <david.maynor@oit.gatech.edu>,
        linux-kernel@vger.kernel.org
Subject: RE: encrypted swap
Date: Tue, 7 Aug 2001 11:53:50 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Maynor wrote:

[...]
> I am saying if you are worried about such things, 
> then start with projects that would not require a 
> hardware crypto card to make i useable.

And earlier wrote:

[...]
> I can't really see the advantage of encrypted swap. 
> At the point it would become effective, the attacker 
> is already on the machine (from remote access or the 
> have physical access) and then its not if you can keep 
> them from getting the info, its only a matter of when.

Wait a second.  Encrypted swap is useful and effective in 
some situations that do not require a hardware crypto card.

Imagine you have:
- a Linux laptop with a small amount of RAM
- Email and important documents encrypted on disk, either
  with GPG / PGP or with an encrypted /home partition.
- Documents and email are decrypted, viewed, and edited by 
  applications, not all of which are SUID root, so 
  unencrypted data might be swapped out.

This is hardly a far-fetched example.

Now that laptop is stolen at an airport. The thief decides
to try to improve his take by grabbing useful information
from documents.  The encrypted documents are untouchable,
of course.  It _doesn't matter_ that the thief has the
hardware, the decryption key is protected by a passphrase
which is _nowhere_ on the hard drive.

The only place that sensitive, unencrypted data could be
on such a machine is in swap.  In fact, it is _likely_ to
be in swap.

Encrypted swap solves this _particular_ problem nicely, 
does it not?  

Torrey
