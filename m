Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316420AbSEOQTI>; Wed, 15 May 2002 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316429AbSEOQTH>; Wed, 15 May 2002 12:19:07 -0400
Received: from relay1.pair.com ([209.68.1.20]:34317 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316420AbSEOQTG>;
	Wed, 15 May 2002 12:19:06 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CE28B5B.A9D44029@kegel.com>
Date: Wed, 15 May 2002 09:22:51 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: RAMFS turned read-only after upgrade to 2.4.19-pre3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy wrote:
> after upgrading from 2.4.19-pre3-ac1 tp 2.4.19-pre8-ac3, 
> RAMFS is suddenly read-only. This is extremely inconvinient ... 
> How can I mend it?

I ran into the same thing.  I only use ramfs as my initial boot
disk; upon boot I pivot root to tmpfs.  Thus in my application,
one workaround was to make the new root directory before creating
the ramdisk image.  Since that was the only write I ever did to
the initial ramdisk, avoiding the write let me boot again.

I have no idea why ramfs went ro.  It is annoying.  I haven't
tracked it down, though, since I was able to work around it.
(I may have to track it down yet, though, since I was thinking
of using ramfs to hold files that I intend to use with sendfile,
since tmpfs and sendfile don't [yet] mix.)
- Dan
