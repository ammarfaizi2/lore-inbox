Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUHHQOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUHHQOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUHHQOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:14:33 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:23503 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S265770AbUHHQOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:14:32 -0400
Date: Sun, 8 Aug 2004 12:14:30 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Juergen Pabel <jpabel@akkaya.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Masking kernel commandline parameters (2.6.7)
In-Reply-To: <200408081430.59840.jpabel@akkaya.de>
Message-ID: <Pine.LNX.4.58.0408081204270.7223@vivaldi.madbase.net>
References: <200408080413.29905.jpabel@akkaya.de>
 <Pine.LNX.4.58.0408072238570.22657@vivaldi.madbase.net>
 <200408081430.59840.jpabel@akkaya.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Aug 2004, Juergen Pabel wrote:
> ps: in case you're referring to the feature itself, what would be a
> more sensible way of passing sensitive data to the kernel? -I didn't
> see any other way.

Yes, I was referring to the feature itself.

I don't know much about dmcrypt, but in the (similar) case of
loop-encrypt, the initrd program could simply call losetup (or mount
-oloop), which would prompt the user for the key and pass it to the
kernel using the LOOP_SET_STATUS64 ioctl. After the mount, you can
pivot_root to your encrypted fs and get rid of the initrd.

I'm sure you can do something similar for dmcrypt.

Eric
