Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263964AbTF2U5i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTF2U5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:57:37 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:35398 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265751AbTF2U4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:56:13 -0400
Date: Sun, 29 Jun 2003 17:07:18 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030629205150.GK27348@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Message-id: <200306291707180150.025E2248@smtp.comcast.net>
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
 <20030629205150.GK27348@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 9:51 PM viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Jun 29, 2003 at 04:29:45PM -0400, rmoser wrote:
>
>> NO!  You're not getting the point at all!
>>
>> You don't need a pair!  If you have 10 filesystems, you need 10 sets of
>> code in each direction, not 90.  You convert from the data/metadata set
>> in the first filesystem to a self-contained atom, and then back from the
>
>[snip handwaving]
>
>> That would be much harder to maintain as well.  It would have to be
>altered
>> every time the filesystem code in the kernel is changed.
>
>Not really, as long as filesystem _layout_ is stable.
>

Maybe heh.

>> I've beaten the O((FS_COUNT)^2) already.  And by the way, it's
>> O((FS_COUNT)*(FS_COUNT - 1_).  There's exactly O(2*FS_COUNT)
>> and o(2*FS_COUNT) sets of code needed total to be able to convert
>> between any two filesystems.
>
>No, you have not.  You are yet to demonstrate that it's doable.
>
>> Now, what's impractical is maintaining two sets of code that do exactly
>> the same thing.  Why maintain code here to read the filesystems, and
>> also in the kernel?  Just do it in the kernel.  Don't lose sight of the
>fact
>> that the final goal (after all else is done) is to modify VFS to actually
>> run this thing as a filesystem.  THAT is what's going to be a bitch.  The
>> conversions are simple enough.
>
>The *SHOW* *THEM*.  You keep repeating that it's simple.  Fine, show that
>it can be done.  Then we can start talking about the rest - until you can
>demonstrate (as in, show the working code) that does what you call simple,
>there is no point in going any further.
>

I'm not coding it.  I wish I could.  heh.  Hmm.... :/  I can't keep the wheels in
my head from cranking out ideas on how to structure the datasystem though
 :/  I'll go diagram that out for a start I guess.

>_That_ is the point of contention.  And no, saying the word "atom" does
>not count as proof of feasibility.  Show how to map metadata between
>different
>filesystem types.  Hell, show that you know what types of metadata are
>there.
>

heh.  Right-o.  Need to find out about filesystem structure...

>Forget about in-core data structures.  Whatever data structures you use,
>it boils down to manipulating on-disk ones - that's kinda the point of
>exercise, right?  Show what should be done with them - with whatever
>in-core
>objects you like.  Assuming that VFS or any other parts of kernel do not
>get into your way and do not impose any restrictions - how would you do
>this
>stuff?  From one on-disk layout to another.  In details.  Then we can go
>and see how to make existing kernel objects live with that.  That will be
>extra condition and it will only make the problem harder.  Until you have
>a solution of easier problem, there's no sense in discussing harder one.

Yeah, I know.  I always do keep the harder problem in mind, though, when
I intend to build it upon the easier problem.  The reason is that I want to
make sure the design isn't going to get in the way once the easier part is
solved.

well I'll go play.

--Bluefox Icy

