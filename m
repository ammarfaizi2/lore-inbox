Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269702AbUICN7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269702AbUICN7C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbUICN6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:58:04 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:765 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S269702AbUICN5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:57:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16696.30683.207905.803165@gargle.gargle.HOWL>
Date: Fri, 3 Sep 2004 09:55:39 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: David Masover <ninja@slaphack.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4137B5F5.8000402@slaphack.com>
References: <20040826150202.GE5733@mail.shareable.org>
	<200408282314.i7SNErYv003270@localhost.localdomain>
	<20040901200806.GC31934@mail.shareable.org>
	<Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	<1094118362.4847.23.camel@localhost.localdomain>
	<20040902203854.GA4801@janus>
	<1094160994.31499.19.camel@shaggy.austin.ibm.com>
	<20040902214806.GA5272@janus>
	<20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk>
	<4137B5F5.8000402@slaphack.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Masover <ninja@slaphack.com> writes:

David> File-as-a-dir has numerous advantages, but enough have been
David> discussed.  Short list is image mounts, tarballs, streams,
David> metas, and namespace unification.  Longer list and explanations
David> can be found if you RTFA.

And it has numerous dis-advantages as well, since it doesn't have a
good set of semantics and syntax defined yet, nor does it explain
except by vigorous handwaving the performance and security impacts it
can have.

My personal feeling is that the mount(8) command should be the tool
used to extract and expose the internal namespace of files like this
and to then graft it onto the standard Unix namespace with gross Unix
semantics, but it's own wacky internal semantics.  This way, standard
tools don't care, but special tools which know how to handle it can do
what they want.


> mount -t tarfs /some/place/on/disk/foo.tar.gz /mnt/tar
> cp /var/tmp/img.gif .
> umount /mnt/tar

Oops!  Someone did a rm /some/place/on/disk/foo.tar.gz between steps
one and two.  Now what happens?  Please define those semantics...

John
