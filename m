Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRHGTtJ>; Tue, 7 Aug 2001 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHGTs7>; Tue, 7 Aug 2001 15:48:59 -0400
Received: from [64.175.255.50] ([64.175.255.50]:64443 "HELO kobayashi.soze.net")
	by vger.kernel.org with SMTP id <S269380AbRHGTsw>;
	Tue, 7 Aug 2001 15:48:52 -0400
Date: Tue, 7 Aug 2001 12:48:34 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: encrypted swap
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com>
Message-ID: <Pine.LNX.4.33.0108071223100.17919-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Torrey Hoffman wrote:

> Imagine you have:
> - a Linux laptop with a small amount of RAM
> - Email and important documents encrypted on disk, either
>   with GPG / PGP or with an encrypted /home partition.
> - Documents and email are decrypted, viewed, and edited by
>   applications, not all of which are SUID root, so
>   unencrypted data might be swapped out.
>
> Now that laptop is stolen at an airport. The thief decides
> to try to improve his take by grabbing useful information
> from documents.  The encrypted documents are untouchable,
> of course.  It _doesn't matter_ that the thief has the
> hardware, the decryption key is protected by a passphrase
> which is _nowhere_ on the hard drive.

As someone just pointed out, if the laptop's suspended, the password for
encrypted swap pretty much has to be in ram, unless you're going to add
hooks in resume such that before anything even starts running again
(possible?) it prompts for the decryption password.  Otherwise, you can't
block swap access, and if the data's encrypted, seems like that will crash
the machine.

With encryption boards, what's to stop either hackers with root or people
with physical access from simply dumping everything sent across the bus to
the encryption card, unless your whole [embedded] computer is tamper-
resistant, the kernel doesn't accept loadable modules, and has been proven
secure.  The only thing that doesn't have to be attack-resistant is the
hd, since it only ever sees encrypted data.

And of course, "tamper-resistant", not "tamper-proof".  I wouldn't bet
very much money against the NSA being able to get at least some data out
of the ibm card.


justin

