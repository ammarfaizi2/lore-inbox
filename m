Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267666AbUIAU1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUIAU1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267682AbUIAUZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:25:03 -0400
Received: from mail.shareable.org ([81.29.64.88]:64201 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267709AbUIAURE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:17:04 -0400
Date: Wed, 1 Sep 2004 21:16:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: "Alexander G. M. Smith" <agmsmith@rogers.com>, spam@tnonline.net,
       akpm@osdl.org, wichert@wiggy.net, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com, vonbrand@inf.utfsm.cl
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901201608.GD31934@mail.shareable.org>
References: <20040829191044.GA10090@thundrix.ch> <3247172997-BeMail@cr593174-a> <20040831081528.GA14371@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831081528.GA14371@thundrix.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:
> Quel horreur!
> Do it in userland, really.

I'm amazed that after all this discussion where all the realistic
implementations are done in userland with kernel support for calling
out to it, there are people who think the kernel is supposed to decode
MP3 files or whatever.

Nobody is advocating that!

> If I  get the time,  I'll write you  a small daemon based  on libmagic
> which  stores  the  file  attributes  in xattrs,  or  if  they're  not
> supported, in some MacOS/Xish per-directory files. Even a file manager
> ("finder") can do that, there's not even the need for a daemon.

How are you going to do the part where the xattr changes when the file
is modified?

(For example, if I edit an HTML file which is encoded in iso-8859-1,
change it to utf-8 and indicate that in a META element, and save it
under the same name, the full content-type should change from
"text/html; charset=iso-8859-1" to "text/html; charset=utf-8".)

I don't see how you can do that without kernel support.

Don't say dnotify or inotify, because neither would work.

-- Jamie
