Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131277AbRBQNfR>; Sat, 17 Feb 2001 08:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRBQNfH>; Sat, 17 Feb 2001 08:35:07 -0500
Received: from [194.213.32.137] ([194.213.32.137]:8964 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131277AbRBQNfA>;
	Sat, 17 Feb 2001 08:35:00 -0500
Message-ID: <20010214202220.A304@bug.ucw.cz>
Date: Wed, 14 Feb 2001 20:22:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matt Stegman <mas9483@ksu.edu>, linux-kernel@vger.kernel.org
Subject: Re: gzipped executables
In-Reply-To: <Pine.GSO.4.21L.0102122251040.24003-100000@unix2.cc.ksu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21L.0102122251040.24003-100000@unix2.cc.ksu.edu>; from Matt Stegman on Mon, Feb 12, 2001 at 11:09:39PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is there any kernel patch that would allow Linux to properly recognize,
> and execute gzipped executables?
> 
> I know I could use binfmt_misc to run a wrapper script:
> 
>     decompress to /tmp/prog.decompressed
>     execute /tmp/prog.decompressed
>     rm /tmp/prog.decompressed
> 
> But that's not as clean, secure, or fast as the kernel transparently
> decompressing & executing.  Is there a better way to do this?

You could do this with uservfs(.sourceforge.net):

ln -s /overlay/path/.../executable.gz#ugz executable

and let uservfs do it for you. It will essentially do what you
described, but it will work on any file.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
