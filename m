Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTDXHhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTDXHhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:37:02 -0400
Received: from mail.gmx.de ([213.165.64.20]:29914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261309AbTDXHhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:37:00 -0400
Date: Thu, 24 Apr 2003 09:49:01 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>, Pavel Machek <pavel@ucw.cz>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030424094901.435101a6.gigerstyle@gmx.ch>
In-Reply-To: <28790000.1051159060@[10.10.2.4]>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com>
	<20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
	<1051142550.4306.10.camel@laptop-linux>
	<1605730000.1051145146@flay>
	<1051152437.2453.26.camel@laptop-linux>
	<28790000.1051159060@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning All:-)

On Wed, 23 Apr 2003 21:37:41 -0700
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> >> > I don't believer I've ever seen things get OOM killed. Instead, page
> >> > cache is discarded until things do fit.
> >> 
> >> What happens if user allocated pages are filling up all the space,
> >> not page cache? Trust me, it happens ;-)
> > 

Yes, it happens...:-)

> > Yep, just because I haven't seen it, doesn't mean a thing. :>. In that

<snip>

</snip>

> The more I think about this, the more it seems so much simpler to just
> require a reserved swap area the size of your RAM to suspend into. Would
> make the code so much simpler ... forget the option bit I suggested earlier
> ;-)

I think most people doesn't interest wheter the code is simple or not...it must work!

What I like to see is that we can define in /etc/fstab an entry for a separate suspend partition or suspend file.

eg. for a partition:
/dev/sda4	none	swsusp	swsp	0 0

or for a file:
/tmp/swsusp	none	swsusp	swsp	0 0

Is it possible? It's also just an idea...

Marc

Also I wouldn't like it, if my programs get OOM-killed just because swap and memory are full! The reasons because I use standby and hybernation are:

1. I hate booting...(If I like booting I would use windows;-))
2. I want to continue working on the last work without opening the programs again
3. I can go home faster:-)
