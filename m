Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTKYKg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTKYKg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:36:58 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:39950 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262291AbTKYKgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:36:55 -0500
Message-ID: <3FC3333E.9010508@aitel.hist.no>
Date: Tue, 25 Nov 2003 11:47:26 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Pravin Nanaware , Gurgaon" <pnanaware@ggn.hcltech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Copy protection of the floppies
References: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pravin Nanaware , Gurgaon wrote:
> Hi All,
> 
> 1> Could somebody suggest me the way to protect floppy from copying it's
> contents. 
> 2> If not possible, will it be possible to make the copied floppy unworkable
> (The copied floppy shouldn't work).  
>    For this I have constraint, I don't want to change the platform, which
> reads this floppy.
> 
> 
> The contents of the floppy could be anything like text file, exe file or
> encrypted file.
> 
Anything you can do others can do.  So this isn't really possible,
as many game vendors discovered in the 80's.  

What you can do, however, is to make a floppy that can't be copied using
the normal ways (cp, gui file manager) that _everybody_ knows how to use.

But it will always be possible for someone determined to copy your floppy,
and it only takes one "expert" copy onto a standard floppy or warez site
before everybody freely may copy the now unprotected stuff.

Floppy protection schemes usually only works for a floppy containing
a program, the idea is that the program checks that the floppy is
genuine and deliberately fails to decrypt contents if it isn't.

For example, the floppy may have some tracks formatted in a nonstandard way,
or some deliberately damaged sectors. (Program tries to write
to those ectors - if it works it knows it is an illegitimate copy.)

Ordinary copy programs can't copy this.  A sector copy program may
faithfully copy a disc sector with a bad checksum, but it won't make
the sector truely unwritable (i.e. scratched).

Experts can get around this in a number of ways though.
1. Study the original floppy and make a copy that is scratched in
   the right places.  Remember, they can do what you can do.
2. Disassemble the program and alter is so it skips the tests. This is
   a popular one.
3. Get the decrypted content from main memory by dumping 
   /dev/kmem or techniques similiar to that.

This makes such schemes unworkable for mass-market stuff, because
you'll quickly reach some hacker that see this as a challenge.
Once the "protection" is broken you have no secret any more.
Just like CSS . . .

Helge Hafting

