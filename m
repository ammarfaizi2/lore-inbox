Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317318AbSFRE6J>; Tue, 18 Jun 2002 00:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317320AbSFRE6I>; Tue, 18 Jun 2002 00:58:08 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:62985 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317318AbSFRE6H>;
	Tue, 18 Jun 2002 00:58:07 -0400
Date: Tue, 18 Jun 2002 00:49:16 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@obiwan
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.22 : fs/intermezzo/presto.c compile error
Message-ID: <Pine.LNX.4.44.0206180044410.3577-100000@obiwan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make bzImage', I received the following error

presto.c: In function `presto_get_permit':
presto.c:625: structure has no member named `p_pptr'
presto.c: In function `presto_put_permit':
presto.c:682: structure has no member named `p_pptr'
presto.c: In function `presto_is_read_only':
presto.c:1136: structure has no member named `p_pptr'
presto.c:1139: structure has no member named `p_pptr'
presto.c:1132: warning: `mask' might be used uninitialized in this function
make[2]: *** [presto.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/intermezzo'
make[1]: *** [intermezzo] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [fs] Error 2

I think that presto_c2m(presto_cache *cache) (looked at dir.c) needs to be 
used, but I attempted that, and it didn't seem to work.

Regards,
Frank

