Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbTF3AsF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 20:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbTF3AsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 20:48:04 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:41381 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265749AbTF3AsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 20:48:02 -0400
Date: Sun, 29 Jun 2003 20:59:02 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030630002527.GA26094@delft.aura.cs.cmu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Message-id: <200306292059020050.0332528F@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
 <200306291629450990.023BC35E@smtp.comcast.net>
 <20030630002527.GA26094@delft.aura.cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 8:25 PM Jan Harkes wrote:

>On Sun, Jun 29, 2003 at 04:29:45PM -0400, rmoser wrote:
>> NO!  You're not getting the point at all!
>>
>> You don't need a pair!  If you have 10 filesystems, you need 10 sets of
>> code in each direction, not 90.  You convert from the data/metadata set
>> in the first filesystem to a self-contained atom, and then back from the
>> atom to the data/metadata set in the new filesystem.  The atom is object
>> oriented, so anything that can't be moved over--like ACLs or Reiser4's
>> extended attributes that nobody else has, or permissions if converting to
>> vfat--is just lost.  Note that if the data has an attribute like
>"Compressed"
>> or "encrypted", it is expanded/decrypted and thus brought back to its
>> natural form before being stuffed into an atom.
>
>I typically call that 'tar' and it works great whenever I want to
>convert from one filesystem to another. I just haven't got a clue why
>you want to implement tar (or cpio) in the kernel as the userspace
>implementation is already pretty usable.
>

tar --inplace --fs-convert --targetfs=reiserfs /dev/hda1

.......  it doesn't like it

>Jan
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



