Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTH0KFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTH0KFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:05:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:34316 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263288AbTH0KFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:05:03 -0400
Message-ID: <3F4C8424.3040204@aitel.hist.no>
Date: Wed, 27 Aug 2003 12:12:52 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm2 didn't try to mount root
References: <20030826221053.25aaa78f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This the last of the messages test4-mm2 gives
when trying to boot:

BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdb1 ...
md:  adding hdb1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1>
md: bind<hdb1>
md: running: <hdb1><hda1>
md0: setting max_sectors to 128, segment boundary to 32767
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
Mounted devfs on /dev
Freeing unused kernel memory: 348k freed
Kernel Panic: no init found.  Try passing init= ...

No surprise it couldn't find an init when it didn't mount
a root.  Seems it didn't even try - there is no
error message about any failed attempt.

test4-mm1 with the same config works on the same machine,
and mounts root between "md: ... autorun DONE" and  "Mounted devfs on /dev"

Root is supposed to be on the raid array, which did come up.
Lilo uses append="root=/dev/md/0".

Helge Hafting

