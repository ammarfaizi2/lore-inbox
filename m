Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUIFQIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUIFQIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 12:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUIFQIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 12:08:21 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:26578 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268253AbUIFQIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 12:08:01 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <m3eklm9ain.fsf@zoo.weinigel.se>
	<20040905111743.GC26560@thundrix.ch>
	<1215700165.20040905135749@tnonline.net>
	<20040905115854.GH26560@thundrix.ch>
	<1819110960.20040905143012@tnonline.net>
	<20040906105018.GB28111@atrey.karlin.mff.cuni.cz>
	<6010544610.20040906143222@tnonline.net>
	<m3wtz7h2l6.fsf@zoo.weinigel.se>
	<826067315.20040906171320@tnonline.net>
	<m3sm9vh06b.fsf@zoo.weinigel.se>
	<20040906155456.GC13539@atrey.karlin.mff.cuni.cz>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 06 Sep 2004 18:07:58 +0200
In-Reply-To: <20040906155456.GC13539@atrey.karlin.mff.cuni.cz>
Message-ID: <m3pt4zjs81.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Who is going to umount it when application crashes, etc? 

Who removes temporary files left behind when an application crashes?
I'd guess a daemon such as autofs could do a very good job here.

>Plus mount required root priviledges last time I checked.

    bash$ ls -l /bin/mount 
    -rwsr-xr-x  1 root root 78504 May  4 23:34 /bin/mount

with proper policies in userspace it allows users to perform mounts.  

I'm not suggesting that the kernel should be unchanged, but really,
some of the proposals here, to put a hell of a lot of complexity into
the kernel it just wet dreams with not much thought of how it affects
the kernel.  What happened to the philosophy of putting complexity and
policy in userspace?  Look at khttpd and tux, they were hacks in the
kernel to try things out.  But what ended up in the kernel is generic
infrastructure that is useful for a lot more applications than just a
web server.  That is the right way to do things.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
