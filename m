Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVFZWpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVFZWpq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFZWms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:42:48 -0400
Received: from pop.gmx.de ([213.165.64.20]:16314 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261636AbVFZWla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:41:30 -0400
X-Authenticated: #9500999
From: Daniel Arnold <arnomane@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 plugins
Date: Mon, 27 Jun 2005 00:41:09 +0200
User-Agent: KMail/1.8
References: <200506262016.j5QKFuXM028867@laptop11.inf.utfsm.cl>
In-Reply-To: <200506262016.j5QKFuXM028867@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506270041.09557.arnomane@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 26. Juni 2005 22:15 schrieb Horst von Brand:
> > And beside that the good usage of my harddisk space (20 Gigabytes) is for
> > me a _very_ strong point in using ReiserFS as the computer I'm talking
> > about is not able to use hard disks larger than 32GB and I don't want to
> > buy a new computer because of that.
>
> And because /you/ can't afford a decent machine /we all/ have to endure
> ReiserFS?!

No you don't need to endure anything because of me. If you don't want 
Reiser-FS v3 oder v4 you don't need to use it. There are several filesystems 
to choose from integrated in the kernel...

I only wanted to make a point that there is a significant group of people and 
circumstances where the "harddisks are cheap" argument doesn't count and 
where a filesystem as ReiserFS is needed (that's why I also made the 
Wikipedia example).

Other people have other priorities and thus they might choose ext3. It's 
perfectly fine with me but why should I endure it not using Reiser4 with the 
vanilla kernel (okay okay I can make my own custom patched kernel, so we all 
end up with incompatible individual kernels in the end if you everytime get 
the answer: "Make your own kernel if you want feature $foobar.")?

> So? Placing the rest into the kernel won't magically make it take up no RAM
> (quite the contrary), or be blindingly fast, or maximally convenient to
> use, or deadlock-free, or whatever.

I was talking about non-existant Reiser4 plugins. I only wanted to illustrate 
what is possible with this flexible system. At the moment I don't see that 
the current Reiser4-code with all the existing plugins makes the kernel fat 
(and I assume it will also not do this in future).

> > Filesystems _are_ storage backends, so existing database applications are
> > duplicating this storage part today as their programmers and users are
> > anoyed by the poor and less flexible possibilities the filesystems
> > provide.
>
> Maybe it is because their storage use patterns just /don't fit/ the regular
> needs of normal applications, for which filesystems have been carefully
> designed and tuned?

Well I guess someone would say the same to a /proc and a /dev device system if 
it wouldn't exist...

Let's look how far we can go with the file system and not say in the 
beginnings of an attempt: "This is not the thing it was intended to be." 
Let's look if people are convinced by Reiser4 and switch back away from 
databases. But this will only work if Reiser4 is in the vanilla kernel. It's 
a pure psychological thing that it will only then be used at large.

> Right. So you compensate for dumb users, who wouldn't distinguish an
> version control system from a camel, by making the filesystem into a
> version control system, which they won't understand anyway, lets alone make
> productive use of it.

No sometimes the dumb user suddenly understands what it is all about if you 
make it easy enough. You can hide the complicated things of current version 
systems with a nice GUI (like KDE does with Cervisia) but the user will 
always have the feeling that he somehow lost touch with the system and feels 
uncomfortable (and will have lots of problems if someday there is a 
failure... as he can't use the standard tools like a file manager to 
manipulate individual files).

> > So with Reiser4 Subversion wouldn't need to base the storage on a
> > database
> [...]
> What double work? There is /one/ database involved when running on, e.g.,
> ext3. Any "unnecessary double work" would squarely be within ReiserFS...
> just one more reason /not/ to use it, wouldn't you say?

Well they invented again the filesystem layer, as quoted by me out of their 
FAQ, due to limitations in current file systems that Reiser4 tries to solve. 
I don't expect Subversion throwing this layer away but at least there could 
be a backend for Reiser4 that can be used by those people that like the idea 
and maybe people are suddenly using such a backend simply because they can 
touch their repository with a filemanager too and feel now much more 
comfortable in case something went wrong with it?

And those reinvented filesystem layers can be found in many places:
*KDE-KIO
*GNOME-VFS
*FUSE

And more and more applications are unsing databases as their backends (most 
times only because it looks cool) and the system gets more and more 
instransparent from the file system perspective.

All the possibilities I was illustrating are currently _non-existant_. But why 
are they only possible ontop of the the current _existing_ Reiser4?

*good disk usage for very small files (in databases most fields are very 
small)
*Atomic operations (very much needed for transactions)
*exensible flexible system (custom extensions in case you need them)

But I should stop arguing now (as I can't anyways say much to the deeper 
technical side) and play with Reiser4 as it seems impossible to move you any 
inch but at least I made the point that Reiser4 maybe is not wanted by 
everyone but at least by a significant group of users and thus it would be 
very sad if it does not make it into the vanilla kernel soon.

Have fun,
Daniel Arnold
