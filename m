Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSL2Tmx>; Sun, 29 Dec 2002 14:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSL2Tmx>; Sun, 29 Dec 2002 14:42:53 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:46250
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261321AbSL2Tmw>; Sun, 29 Dec 2002 14:42:52 -0500
Message-ID: <3E0F5233.5050209@redhat.com>
Date: Sun, 29 Dec 2002 11:51:15 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Jakub Jelinek <jakub@redhat.com>
Subject: glibc binaries w/ sysenter support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After quite some fiddling we finally have some glibc binaries with
sysenter support.  The problems were not in the sysenter code but in
coordinating everything in ld.so so that it works on old kernels
(without TLS support).

Anyway, the result can be downloaded from

  ftp://people.redhat.com/drepper/glibc/2.3.1-25/

These RPMs are drop-in replacements for the ones in the last Red Hat
beta, released about a week ago.  They haven't been tested in any other
environment.  They also use NPTL as the default libpthread.  As is the
case with every beta release code, do *not* install them on production
machines.  We see no problems with the new code but your mileage may
vary.  If you see problems ideally file them in Red Hat's bugzilla
(remember these are RH-specific binaries).  Alternatively send reports
to libc-alpha@redhat.com.  If you suspect the problem is related to the
kernel side you know where to post.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

