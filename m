Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbSLNPyC>; Sat, 14 Dec 2002 10:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267631AbSLNPyC>; Sat, 14 Dec 2002 10:54:02 -0500
Received: from [81.2.122.30] ([81.2.122.30]:13317 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267630AbSLNPyB>;
	Sat, 14 Dec 2002 10:54:01 -0500
From: John Bradford <john@bradfords.org.uk>
Message-Id: <200212141613.gBEGDURa001149@darkstar.example.net>
Subject: Re: Symlink indirection
To: andrew@walrond.org (Andrew Walrond)
Date: Sat, 14 Dec 2002 16:13:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DFB3983.3090602@walrond.org> from "Andrew Walrond" at Dec 14, 2002 02:00:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (contrived example with made-up mount option --overlay)
> 
> mkdir a
> echo "a/x" > a/x
> echo "a/y" > a/y
> echo "a/z" > a/z
> 
> mkdir b
> echo "b/y" > b/y
> 
> mkdir c
> echo "c/z" > c/z
> 
> mkdir d
> mount --bind a d
> mount --bind --overlay b d
> mount --bind --overlay c d
> 
> cat d/x
> "a/x"
> 
> cat d/y
> "b/y"
> 
> cat d/z
> "c/z"

BSD has a mount_union command which does this, as well as mount_null,
which allows you to effectively mount a filesystem more than once.

I'm not sure how well it works, though, it might only work on some
filesystems.

John.
