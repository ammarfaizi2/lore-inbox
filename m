Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282807AbRK0F1Z>; Tue, 27 Nov 2001 00:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282808AbRK0F1P>; Tue, 27 Nov 2001 00:27:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33157 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282807AbRK0F1G>;
	Tue, 27 Nov 2001 00:27:06 -0500
Date: Mon, 26 Nov 2001 21:26:58 -0800 (PST)
Message-Id: <20011126.212658.82514202.davem@redhat.com>
To: trini@kernel.crashing.org
Cc: olh@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] net/802/Makefile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011126221012.C13091@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011126203527.C31937@suse.de>
	<20011126.114045.102135510.davem@redhat.com>
	<20011126221012.C13091@cpe-24-221-152-185.az.sprintbbd.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tom Rini <trini@kernel.crashing.org>
   Date: Mon, 26 Nov 2001 22:10:12 -0700

   On Mon, Nov 26, 2001 at 11:40:45AM -0800, David S. Miller wrote:
   > No, because it is writable by the user in every kernel source tree I
   > have ever seen, the change makes no sense.
   
   You haven't tried a BitKeeper tree then.  You have to explicitly get
   write permission.
   
That doesn't make any sense to me.

Firstly, the *.c file should be newer than the template it is
generated from, so the rule which tries to write the file should
never run if your file timestamps are setup correctly.  So get the
timestamps correct in your bitkeeper trees :)

Secondly, there is no reason the version control system should prevent
a file from being writable to the user who owns the file, especially
in a case like this.

In fact, this is one of the things that makes my balls hurt when I
download source tarballs from some places.  I have to chmod +w the
files to edit them just to make hack test local changes that I don't
care if anyone ever sees ever again.  At that point I'm fighting
whatever source control system those sources came from.
