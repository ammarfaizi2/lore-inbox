Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136346AbRDWCjE>; Sun, 22 Apr 2001 22:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136339AbRDWCiy>; Sun, 22 Apr 2001 22:38:54 -0400
Received: from [211.99.247.66] ([211.99.247.66]:6665 "HELO lustre.us.mvd")
	by vger.kernel.org with SMTP id <S135519AbRDWCil>;
	Sun, 22 Apr 2001 22:38:41 -0400
Date: Sun, 22 Apr 2001 19:40:10 -0700 (PDT)
From: "Peter J. Braam" <braam@mountainviewdata.com>
To: adilger@turbolinux.com, sct@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ext3-users@redhat.com
Cc: ericm@mountainviewdata.com
Subject: Ext3 for Linux 2.4 progress report
Message-ID: <Pine.LNX.4.21.0104221927020.11051-100000@lustre.us.mvd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas, Stephen, 

We have a lot working now: 

1. journal recovery and initialization stuff is working
2. transactions go to the disk
3. infrastructure is there to do transcactions
4. ext3_create is fully operational. 

The problems we have seen mostly have to do with differences in which
buffer heads are being initialized.  Things like b_transaction etc. were
not cleaned up.

There are more buffer head problems around, but we are debugging them
quickly now.

You can play with this, make a loop device, mount it and to things like
touch (NOTE: only file creations have been handled so far).  If you
re-mount a dirty ext3 image, it will recovery.  The first few always
work, but at present things go wrong when bdflush kicks in.

We left a patch at: 

ftp.inter-mezzo.org:/pub/ext3/242-ac26-1um.ext3-ph5_4.patch.gz

In the patch there are markers of the form @@@ with your names, asking for
help!

- Peter -

