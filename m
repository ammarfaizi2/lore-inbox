Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265315AbSJXFgq>; Thu, 24 Oct 2002 01:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265317AbSJXFgq>; Thu, 24 Oct 2002 01:36:46 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:50696 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265315AbSJXFgp>;
	Thu, 24 Oct 2002 01:36:45 -0400
Date: Thu, 24 Oct 2002 01:42:54 -0400 (EDT)
Message-Id: <200210240542.g9O5gsh357557@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: acahalan@cs.uml.edu
Subject: vmstat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While going over the vmstat man page, I spotted this:

       All linux blocks  are  currently  1k,  except  for  CD-ROM
       blocks which are 2k.

This doesn't seem to be true. I need help determining when
things changed so that I can update the documentation.
I've been checking kernels with commands like this:

dd bs=1024k count=1 if=/dev/cdrom of=/dev/null

Linux 2.4.16 and 2.5.42 both seem to use units of 1024 bytes.
Linux 2.2.18 does something weird, but NOT what is described in
the vmstat man page. With 2.2.18, non-CD blocks are 4096 (!!!)
bytes and CD blocks are indeed 2048 bytes.

I suppose there was an even older kernel, perhaps 2.0.xx,
that did the non-CD blocks in units of 1024 bytes. I can
no longer compile 2.0.xx, so I need some help testing that.

Also, am I right about 2.2.xx kernels? Are any of these
kernels affected by block size of a mounted filesystem?
Does it matter if I use a /dev/raw* device? Does any
kernel use different units for file bodies and metadata?

--
http://procps.sf.net/
http://procps.sf.net/procps-3.0.5.tar.gz
