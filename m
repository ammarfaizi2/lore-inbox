Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUBIMHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUBIMHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:07:39 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24014 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265083AbUBIMHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:07:37 -0500
Message-ID: <40277807.6787981A@namesys.com>
Date: Mon, 09 Feb 2004 15:07:35 +0300
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>, Jamie Lokier <jamie@shareable.org>
CC: the grugq <grugq@hcunix.net>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <40251601.6050304@namesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> Exactly right.
> 
> Hans
> 
> Jamie Lokier wrote:
> 
> >the grugq wrote:
> >
> >
> >>If, on the other hand, we have a threat model of, say, the police, then
> >>things are very different. In the UK, there is a law which requires you
> >>to turn over your encryption keys when the court demands them. The
> >>police have a tactic for extracting keys which involves physical
> >>violence and intimidation. These are very effective against encryption.
> >>
> >>
> >
> >This is how to implement secure deletion cryptographically:
> >
> >   - Each time a file is created, choose a random number.
> >
> >   - Encrypt the number with your filesystem key and store the
> >     encrypted version in the inode.
> >
> >   - The number is used for encrypting that file.
> >
> >Secure deletion is then a matter of securely deleting the inode.
> >The file data does not have to be overwritten.
> >
> >This is secure against many attacks that "secure deletion" by
> >overwriting is weak against.  This includes electron microscopes
> >looking at the data, and UK law.  (The police can demand your
> >filesystem key, but nobody knows the random number that belonged to a
> >new-deleted inode).

Also they will demand this random number since the court can consider it
as a part of your secret key. So just delete your secret key without creating
meaningless infrastructure ;)
Edward.

> >
> >There is a chance the electron microscope may recover the number from
> >the securely deleted inode.  That is the weakness of this system,
> >therefore the inode data should be very thoroughly erased or itself
> >subject to careful cryptographic hding.
> >
> >-- Jamie
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> >
