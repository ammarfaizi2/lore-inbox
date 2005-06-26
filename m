Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVFZE4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFZE4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 00:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFZEy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 00:54:26 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:17676 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261181AbVFZEx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 00:53:57 -0400
Message-ID: <42BE34E4.3000203@slaphack.com>
Date: Sat, 25 Jun 2005 23:53:56 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506260401.j5Q41iR4024249@laptop11.inf.utfsm.cl>
In-Reply-To: <200506260401.j5Q41iR4024249@laptop11.inf.utfsm.cl>
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
>>>>Horst von Brand wrote:
>>>>
>>>>>David Masover <ninja@slaphack.com> wrote:
>>>>>
>>>>>>Hans Reiser wrote:
>>>>>>
>>>>>>>Jeff Garzik wrote:
> 
> 
> [...]
> 
> 
>>>>"Ain't broke" is the battle cry of stagnation.
> 
> 
>>>I see it as the battle cry of those that are looking for /real/
>>>problems to solve.
> 
> 
>>I'll refer you to my other rant about stagnation and oil.
> 
> 
> Read it. Makes no sense, wind and solar power have their /own/ problems,
> environmentally speaking. Besides, as things stand today, they are *extremely*
> expnsive and hard to use, so next to useless (for now).

Have you bothered to research them?

The main problem is in the construction.  After that...  hard to use?
Not really.  Expensive?  They pay for themselves, eventually.

Plus, they get better as money goes into them.  Oil *can't* get much
better, but all the money goes there, instead of into alternatives.
Thank you, Republicat administration...

> Maybe. It's up to /you/ to convince the head kernel hackers (and me on the
> way).
> 
> 
>>                                               I guess we'll only know
>>if we let Reiser4 merge...
> 
> 
> No. Just like devfs was "the obvious right way", it /had/ to be merged
> ASAP, "wrinkles will be ironed out later". Turned out it wasn't wrinkles,
> but fundamental brokenness, and it was soon abandoned by the people who
> promised to maintain it forever. And now we have the flamewar about its
> removal...

Should it have been kept out in the beginning, before we knew we needed
udev?  Would we have udev at all, had devfs not been merged?

>>>>But, there are some things Reiser does better and faster than ext3,
> 
> 
>>>Yes, I've heard it is supposed to be faster on huge directories, and
>>>doesn't run out of inodes. And it is more efficient spacewise on small
>>>files. But then again, space is extremely cheap today...
> 
> 
>>Speed isn't.  CPU is, but not disk speed.  And packing stuff more
>>efficiently, without actually compressing it, will give you some of that
>>speed.
> 
> 
> For my current uses, ext3 is plenty fast enough. No pressing need to change.

That is the problem I attempted to illustrate with the oil rant.  No
pressing need to change doesn't mean that something astronomically
better shouldn't be adopted.

Amish people live just fine.  There's no pressing need for them to
change.  But I bet that many of them would be happier if they had a car.


>>>And again, on a list around here I've seen several cries for help with
>>>completely hosed filesystems, all ReiserFS. No solution has ever come
>>>forth.
> 
> 
>>I haven't been counting, but I've seen a number of solutions fly around
>>reiserfs-list for people with reiser4 problems.
> 
> 
> It was ReiserFS 3. Maybe the problems are fixed now, but as they say about
> burned children...

speaking for yourself?

>>A lot of what people like about ext3 is its stability and fairly
>>universally accepted format.  A lot of what people like about XFS is its
>>stability and speed, mainly with large files.  A lot of what people like
>>about Reiser4 (as it is today) is its speed, with large and especially
>>with small files.
> 
> 
> Right. And mushing it all together is way more likely to combine all /bad/
> features than to retain some of the /good/ ones.

Actually, it wasn't "mushing it all together".  It ended up throwing out
a fair bit of it in the example I was talking about.  But I really
shouldn't be arguing that.  It's not what people care about.

>>Those are broad and somewhat uneducated statements, but I doubt most
>>people care what FS they are using if the stability and performance is
>>what they want.  In that case, why have so much duplicated effort
>>between different filesystems -- even between ISO and UDF and Reiser and
>>XFS -- when most of what's really different is the on-disk format and
>>the optimization?
> 
> 
> Because they are different on-disk and are optimized for different uses,
> perhaps? I can't use ext3 for reading my CDs, I need NTFS to access the
> Windows partition here, ...

As things stand.

And it would be pointless to change some of those, like CDs.  But then,
transparent decompression as a plugin might be better.

>>So, in this hypothetical situation where ext3 is a reiser4 plugin,
>>suddenly all the ext3 developers are trying to improve the speed and
>>reliability of reiser4, which benefits both ext3 and reiser4, instead of
>>just ext3.
> 
> 
> I guess that it won't ever turn out to be that simple. ext3 developers will
> have to consider not screwing up XFS, etc. And I don't see any real
> difference there from where we stand today... just a bigger mess: VFS with
> ReiserFS with plugins for ext3, instead of VFS with ext3. No gain, much
> pain.

That you don't see the gain doesn't mean it doesn't exist.

I don't deny the pain, though I don't think it will be as bad as you
think.  For one thing, storage plugins are fairly self-contained, or
should be.

>>>And that would surely break Windows compatibility (because you have to keep
>>>the data on what to encrypt one the filesystem itself). Besides, having
> 
> 
>>Aside from what someone else already said about this, why not just have
>>support for accessing, say, a .gpg file as transparently decrypted?
> 
> 
> That should, if anything, be a /user/ decision, not a /kernel/ one. Even
> sometimes decrypt, sometimes don't.

Sometimes decrypt, sometimes don't, would certainly be allowed.

What's not allowed now is an easy way to vim an encrypted file without
patching/wrapping vim or dealing with ramdisks.  And that's assuming vim
is the only program I want to use.

Transparency is a good thing.

>>                                                                     You
>>don't even need file-as-directory, just create a file called foo which
>>is really the decrypted version of foo.gpg.  No need to change the
>>format, just the filesystem.
> 
> 
> No need to change the filesystem, learn to use the tools at hand.

Read above.

>>>pgp, or gpg, or crypt, or my own whacky encryption proggie do the job in
>>>/userland/, and not shoving into the kernel and so down the next user's
>>>throat, is in the end a largeish part of what Unix is all about for me.
> 
> 
>>Do you use ipv6?
> 
> 
> Sometimes.
> 
> 
>>                  I don't.  And it's not shoved down my throat, either,
>>although it's in the kernel.  I simply disable it, and you would (I'm
>>sure) disable the crypto stuff.
> 
> 
> An Internet standard is a quite different kettle of fish than the pet
> experimental filesystem for a minority operating system...

"standard"?  How many Linux people use ipv6?  How many use reiser4?

And what's your point, anyway?  Disable it if you don't like it.

>>Plus, as someone else said, it's much easier to do
>>$ vim /some/encrypted/file
>>than
>>$ gpg --decrypt /some/encrypted/file > /some/decrypted/file
>>$ vim /some/decrypted/file
>>$ gpg --encrypt /some/decrypted/file > /some/encrypted/file
>>$ shred /some/decrypted/file
> 
> 
> So what? Write your script to do it. Or use emacs, I'm sure it either has
> now or will soon have a plugin for it... much easier to develop, much more
> flexible to use, ...

more flexible?

You don't seem to understand plugins.  That makes sense; you don't want to.

Plugins are far more flexible than trying to patch every single program
I want to deal with.  And the script described doesn't work because
shred doesn't work, meaning you have to deal with ramdisks, which is
even worse and less likely to work out-of-the-box.

>>Not to mention, shred doesn't work on modern filesystems, so you need to
>>either patch vim (and any other program you might want to use), create
>>an actual ramdisk, or deactivate swap and mount a tmpfs.
> 
> 
> Right. And all this complex futzing around (and making sure the unencrypted
> data doesn't remain if the power is cut in the right moment, and...)

Unencrypted data stays in RAM...

with plugins.

>>On doing stuff in userland:  I am all for moving tons of stuff to
>>userland, but not until someone does a microkernel right, if it's even
>>possible.  And even then, I'd probably still use Linux and argue for
>>some stuff in the kernel, because Linux has developers.  Developers.
>>Developers.  Developers.
> 
> 
> Sorry, I don't buy this. Linux (the kernel) has tons of developers. But
> that doesn't mean everybody is interested in everything. Just like there
> are probably much more userland developers (for one, it is /much/ easier to
> work with...), and there not everybody is interested in everything. Putting
> stuff in the kernel that doesn't belong there (== can't be done elsewhere)
> is useless bloat.

90% of what's currently in the kernel can be done elsewhere.  Witness HURD.

Doesn't mean it should.  Witness HURD.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr4043gHNmZLgCUhAQI4/A/9E6kVoYyVgQWFrrw7SO6e6vVZzQufsTFe
h2prUuaITxSDYc6oO6gR4UorkQAGtHjFFKCzdyH+/Eo2cmYAGtom14y8aNjWqQOj
iz4hqyH4RZJ3eSP0/YsMdopoDpkdtrlD6QCWL49C7A1h1Mrq0gL+SrRNzpLYc+QW
XfyqQppMgDRIQfCHKG+ZgS9cloW1HnYHppxYakvhkS4ZiFktEi1UHXj+2GQ22Mm5
EN56EHRthS8v2k7vOdsrkQE02lrgDtWWOt8bkrkHFCFB6lU9oXbqlKHWRrU/dd27
zYgvajgVZWjGT3iAXgyhcojCuIEpyOB2+Cegdga2D/H+kxh8tk1J1f1MJh9oXosb
4ScrlUIq+ghVx2+/YMvTmA8geKMqqi9OBvB1npfFXklXJHa/QJzTTo3/MJGxJ6Ko
fKyG0sWWNwbMdCmLoCQp1T+WycxMeOILw8jheVfQbF+JAXm/ialDXJ/rH5RYHeG4
vhlZHxKqihgiuQ0ZGvj8niR5vlei9tKZ8fBFiVgDxQhoUhrutiVQKIzxT6YXMQqM
PpXefWdDNi4vnNFn6eDVcXTs14kvBod8SM/5WxKUnnlCJNvjFUwo5x4lQ9iXnlYT
LHbJ06lGbLU6y8RfaY2+eBYziyMSStql77mwW9y7WssXI0cV7VzgEYSTd+S1eBN5
Yr+8chQqWOI=
=/wpm
-----END PGP SIGNATURE-----
