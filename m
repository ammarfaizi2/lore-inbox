Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263323AbVFYELY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbVFYELY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbVFYELY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:11:24 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:4623 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263323AbVFYEKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:10:37 -0400
Message-ID: <42BCD93B.7030608@slaphack.com>
Date: Fri, 24 Jun 2005 23:10:35 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
In-Reply-To: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
>>Horst von Brand wrote:
>>
>>>David Masover <ninja@slaphack.com> wrote:
>>>
>>>>Hans Reiser wrote:
>>>>
>>>>>Jeff Garzik wrote:
> 
> 
>>>[...]
> 
> 
>>>>>You missed his point.  He is saying ext3 code should migrate towards
>>>>>becoming reiser4 plugins, and reiser4 should be merged now so that the
>>>>>migration can get started.
> 
> 
>>>>Sort of.
>>>>
>>>>I think ext3 would be nice as a reiser4 plugin.
> 
> 
>>>What for? It works just fine as it stands, AFAICS.
> 
> 
>>So does DOS.
> 
> 
> I'm sorry?
> 
> 
>>             Do you use DOS?
> 
> 
> Good riddance, no! Not for something like 15 years.

[...]

>>"Ain't broke" is the battle cry of stagnation.
> 
> 
> I see it as the battle cry of those that are looking for /real/ problems to
> solve.

I'll refer you to my other rant about stagnation and oil.

And, listen to yourself.  "Good riddance, no, I don't use DOS" but
"Ain't broke is the battle cry of those looking for real problems to solve."

You can solve real problems in DOS, it's usable, it ain't broke, there
are even some decent games (doom) and windowing systems (win3.1 and
others) for it.

But Linux is better.  DOS ain't broke, but Linux is better.  So maybe
VFS ain't broke, but plugins would be better.  I guess we'll only know
if we let Reiser4 merge...

>>But, there are some things Reiser does better and faster than ext3,
> 
> 
> Yes, I've heard it is supposed to be faster on huge directories, and
> doesn't run out of inodes. And it is more efficient spacewise on small
> files. But then again, space is extremely cheap today...

Speed isn't.  CPU is, but not disk speed.  And packing stuff more
efficiently, without actually compressing it, will give you some of that
speed.

Also, space is not so cheap that I won't take 25% more.

> And again, on a list around here I've seen several cries for help with
> completely hosed filesystems, all ReiserFS. No solution has ever come
> forth.

I haven't been counting, but I've seen a number of solutions fly around
reiserfs-list for people with reiser4 problems.

>>                                                                    even
>>if you don't count file-as-directory and other toys.  There's nothing
>>ext3 does better than Reiser, unless you count the compatibility with
>>random bootloaders and low-level tools.
> 
> 
> For me, those are quite critical...

There have been patches...

>>>>                                               Not everyone will want
>>>>to reformat at once, but as the reiser4 code matures and proves itself
>>>>(even more than it already has),
> 
> 
>>>I for one have seen mainly people with wild claims that it will make their
>>>machines much faster, and coming back later asking how they can recover
>>>their thrashed partitions...
> 
> 
>>You know how many I've had thrashed on Reiser4?  Two.  The first one was
>>with a VERY early alpha/beta, and the second one was when I dropped a
>>laptop and the disk failed.
> 
> 
> OK. Know how many I thrashed with ext2/3? I remember 3, could have been as
> many as 5. One was due to a failed disk, another one because of DMA to a
> disk causing slow corruption. Another one I believe was due to a odd kernel
> compiled with a snapshot gcc a long time back, plus power loss at the wrong
> time. And that is from using ext2/3 since they were in early beta. On
> several machines at the same time, over years. I'd have to say that there
> isn't much of a difference.
> 
> 
>>And it does make certain things faster.  For one thing, "emerge sync" on
>>Gentoo is twice to four times as fast, and /usr/portage is 75% as big,
>>as on ReiserFS (3).
> 
> 
> That can't all be due to on-disk format.

It's not compression.  What do you think it is?

To be fair, it's gotten a bit slower recently.  Wish that repacker was
done.  I think it's actually gotten just a little slower than it ever
was on v3, but v3 was awhile ago for me, and Gentoo has been growing a
lot.  /usr/portage is probably twice as big now as it was then.

If you want, I can do some unscientific benchmarks.

>>>>                                the ext3 people may find themselves
>>>>wanting some of the more generic optimizations.
> 
> 
>>>They'll filch them in due time, don't worry.
> 
> 
>>Duplication of effort.  With plugins, we can optimize the upper layers
>>of ALL filesystems, regardless of the lower layers, in such a way that
>>it is optional.
> 
> 
> Generic optimizations how, if they need VFS support?!

This was about a hypothetical ext3 format as a reiser4 storage plugin.
I'm not sure how this ties into the VFS stuff.

>>                 I'm sure it's far easier to write a Reiser storage
>>plugin than a brand new FS.
> 
> 
> Comparing apples and oranges tells you what?

That I'd rather have oranges?

A lot of what people like about ext3 is its stability and fairly
universally accepted format.  A lot of what people like about XFS is its
stability and speed, mainly with large files.  A lot of what people like
about Reiser4 (as it is today) is its speed, with large and especially
with small files.

Those are broad and somewhat uneducated statements, but I doubt most
people care what FS they are using if the stability and performance is
what they want.  In that case, why have so much duplicated effort
between different filesystems -- even between ISO and UDF and Reiser and
XFS -- when most of what's really different is the on-disk format and
the optimization?

So, in this hypothetical situation where ext3 is a reiser4 plugin,
suddenly all the ext3 developers are trying to improve the speed and
reliability of reiser4, which benefits both ext3 and reiser4, instead of
just ext3.

>>Eventually, once competition is only based on storage format, we could
>>end up with just one format.  Just one filesystem!  (except for
>>fat/ntfs/iso/udf/network...)  And in the open source world, sometimes a
>>single product is a good thing.
> 
> 
> Sorry, I don't think this will come to pass in our lifetime, if ever. There
> are different requirements, and the way to cater to them is different
> solutions. That has always been what Linux (as opposed to the propietary
> and even some open source systems) is all about...

egrep and fgrep are the same program.  A lot of the code is shared, I'm
sure.  But you change some settings and they suddenly solve entirely
different problems.

You don't need a wholly different solution if you can adapt an existing
one.  That's what plugins are all about -- adapting one solution to any
number of requirements, so that people can focus on making that one
solution better.

But, you may be right about it not happening in our lifetime, as I said:

>>>>But, I don't think that will realistically happen at all.

People are stubborn.

[...]

>>>>                  and vfat people may decide they want cryptocompress,
> 
> 
>>>I'm sure they don't, because it is mostly for Windows and assorted devices
>>>(pendrives, digital cameras, ...) compatibility.
> 
> 
>>I, for one, would like to use a pendrive and have certain files be
>>encrypted transparently, only for use on Linux, but others be ready to
>>transfer to a Windows box.
> 
> 
> And that would surely break Windows compatibility (because you have to keep
> the data on what to encrypt one the filesystem itself). Besides, having

Aside from what someone else already said about this, why not just have
support for accessing, say, a .gpg file as transparently decrypted?  You
don't even need file-as-directory, just create a file called foo which
is really the decrypted version of foo.gpg.  No need to change the
format, just the filesystem.

> pgp, or gpg, or crypt, or my own whacky encryption proggie do the job in
> /userland/, and not shoving into the kernel and so down the next user's
> throat, is in the end a largeish part of what Unix is all about for me.

Do you use ipv6?  I don't.  And it's not shoved down my throat, either,
although it's in the kernel.  I simply disable it, and you would (I'm
sure) disable the crypto stuff.

Plus, as someone else said, it's much easier to do
$ vim /some/encrypted/file
than
$ gpg --decrypt /some/encrypted/file > /some/decrypted/file
$ vim /some/decrypted/file
$ gpg --encrypt /some/decrypted/file > /some/encrypted/file
$ shred /some/decrypted/file

Not to mention, shred doesn't work on modern filesystems, so you need to
either patch vim (and any other program you might want to use), create
an actual ramdisk, or deactivate swap and mount a tmpfs.



On doing stuff in userland:  I am all for moving tons of stuff to
userland, but not until someone does a microkernel right, if it's even
possible.  And even then, I'd probably still use Linux and argue for
some stuff in the kernel, because Linux has developers.  Developers.
Developers.  Developers.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrzZOngHNmZLgCUhAQLk/w//dwfRaR5mtrznECpLMtpfNTm/n0EK2gqC
ABYClsvcyKPzFtRTYnhZmBmVvAIueJpaReRmrR3QryESoeD6zftrxpuyvgcxxFRA
BUIZcXKtqDF7ILmwCgSN0kB3ltD859q0E9ceJz5/lQZJwIJ2JN1huDM9xsOtw4sW
5HZEwSd6C46HArHD5fnnljppCgxV9ozVDfVzWs2GHU9r9cYZ+y9FU/kWIiuw78Ub
fSSF7UqXd+QP0PWkkC7bAA9EtePT4Xd875WX7etgUmJRqVbf6erzPNq34b8V4r0r
6o2QFd5j4ZjpUvAeUzlMivSwFl10Yta+I9E3MHkYIm/86pX3GmPY5W24YfkDKsdS
Y1odr3HYHt16QIJF3MPO3724PsSax+c9vmF7ANU+2QadtyQFrU0aasKxehTPnp9M
PjShkWpWLGCG2YyesM3lq2HzydbljBraFUfzK9LKKoTqBk0jd6kcUrP8869NPo94
/stcyLSa/1gSAsSX+97Gs8CpQZ9JeJp7cMyDdrbR68h0xAg+UGK7tDez5j7VY9kc
cSNo+T+W8OBiRPfz7Zg39ltHIeaPT/8THPKRmOLHWXK2duW+RmZBTDPK22Cwbv83
0f9RgRtm1q1FYG1q4gH373V/hjmvZIXGrN+/I5mU6P43iVrLuz/7MIWAGkQyXS3M
nOCoZV7WiHY=
=XUC1
-----END PGP SIGNATURE-----
