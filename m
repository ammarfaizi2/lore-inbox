Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRCZXms>; Mon, 26 Mar 2001 18:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRCZXmi>; Mon, 26 Mar 2001 18:42:38 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:32080 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129679AbRCZXm3>;
	Mon, 26 Mar 2001 18:42:29 -0500
Message-ID: <20010327014145.A7826@win.tue.nl>
Date: Tue, 27 Mar 2001 01:41:45 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: John.L.Byrne@compaq.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <3ABFB20E.DFB37BFA@kahuna.cag.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3ABFB20E.DFB37BFA@kahuna.cag.cpqcorp.net>; from John Byrne on Mon, Mar 26, 2001 at 01:18:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 01:18:06PM -0800, John Byrne wrote:

> Do you have any interest in doing away with the concept of major and
> minor numbers altogether; turning the dev_t into an opaque unique id?
> 
> At the application level, the kinds of information that is derived from
> the major/minor number should probably be derived in some other manner
> such as a library or system call. Code that determines device type by
> comparing with the major/minor numbers should probably be discouraged in
> the long run and this could be a good time to start.

Programs that use explicit major/minor information are probably broken
or at least very nonportable.
On the other hand, unfortunately the Unix API has a few explicit
occurrences of major/minor. For example, one has ls(1) and mknod(1).
