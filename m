Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTFKUs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTFKUsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:48:42 -0400
Received: from fmr03.intel.com ([143.183.121.5]:57048 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S264491AbTFKUsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:48:08 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DA1749F@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'john@grabjohn.com'" <john@grabjohn.com>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: cachefs on linux
Date: Wed, 11 Jun 2003 14:01:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: john@grabjohn.com [mailto:john@grabjohn.com]
> 
> ...
>
> There are a lot of things we _could_ add to filesystems, E.G.:
> 
> * Appending to a read-only filesystem on a separate volume

That can be done with a union fs.

> * File versioning

There was a thread one or two months ago regarding all this,
grep the archives.

> * Transparent, variable compression

There was a project to do this in ext2, but I don't remember
what happened to it - I think that at the end is simpler to
do that at the user level (think something like Gnome VFS or
KDE's KIOs).

> * Format conversion, (I.E. write a png file to a filesystem, and it is
> 			   automatically visible as half a dozen other
> 			   formats, without them actually existing on
> 			   the disk)

Mr. Van Riel? Where are you?

> * Priorities, (E.G. temp files could have a bit to indicate that we
> 		    don't really care how long they remain in
> 		    write-cache, instead of flushing them along with
> 		    other more-important-to-get-to-the-oxide data)

Having a tmpfs mounted in /tmp does the trick, more or less. 
Then it is a matter of discipline: if a file is temporary, 
stick it somewhere in /tmp.

> * WORM mode, (I.E. start at block 1 and use blocks sequentially, never
> 		   re-using blocks - makes a tape somewhat usable as a
> 		   block device)

What for? They are too slow; given the price of a gigabyte now, 
and taking into account that IDE drives can store more than tapes,
it makes little sense (I would even say for long-term storage).
YMMV, though.

Cheers,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
