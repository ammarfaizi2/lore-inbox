Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVGJWUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVGJWUR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVGJWUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 18:20:13 -0400
Received: from mxfep04.bredband.com ([195.54.107.79]:40408 "EHLO
	mxfep04.bredband.com") by vger.kernel.org with ESMTP
	id S262138AbVGJWTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 18:19:23 -0400
Message-ID: <42D06531.9060903@stesmi.com>
Date: Sun, 10 Jul 2005 02:00:49 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050630153738.GU11013@nysv.org>	<200506301952.j5UJqPrn013513@laptop11.inf.utfsm.cl> <87wto5yo9o.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87wto5yo9o.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hubert Chan wrote:
> On Thu, 30 Jun 2005 15:52:25 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:
> 
> 
>>>This doesn't even invalidate the userland VFSs of the other guys,
>>>they're still needed for systems whose kernels don't have a metadata
>>>facility.
> 
> 
>>So the metadata facility in kernel won't be used, for portability's
>>sake.
> 
> 
> Oh gee.  Every operating system does threads differently.  Mozilla has
> an abstraction layer called nspr that allows them to handle threads
> portably.  glib/gtk has their own threads abstraction.  On Windows, nspr
> will use the Windows method for handling threads.  On Linux, it will use
> the Linux way.  On systems that don't support threads, it can usually
> emulate it using timers.
> 
> It's the exact same thing with the userspace VFS.  If GNOME needs to
> handle extended attributes, it can use one mechanism under one operating
> system, or emulate it using some ugly hack on operating systems that
> don't support extended attributes.
> 
> Isn't that the whole point of having a VFS?
> 

So basically if I write a program that works in both Gnome and KDE
I should (according to your description) implement my own VFS that
will use the Gnome or KDE VFS that will then use the OS VFS.

Is it only me finding that a little silly?

I mean, if I am to have the same functionality under neither Gnome
nor VFS and they don't support something I need I _NEED_ a vfs so
that my program is so totally independent on anything at all.

My program calling My VFS which calls KDE/Gnome's VFS which calls the OS
VFS will be slowe than just calling the VFS immidiately - I do hope you
can see that.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFC0GUxBrn2kJu9P78RApViAJ4q6BrVh0H19S4pN+Zc0bqh7zk2sgCeLRVK
8b+qlg2BHjwxg8HnVANQ5XA=
=2uNQ
-----END PGP SIGNATURE-----
