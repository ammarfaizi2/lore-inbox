Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTH0Lou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263326AbTH0Lou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:44:50 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:58372 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263288AbTH0Lot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:44:49 -0400
Message-ID: <3F4C9B85.7040602@aitel.hist.no>
Date: Wed, 27 Aug 2003 13:52:37 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm2 didn't try to mount root
References: <20030826221053.25aaa78f.akpm@osdl.org>	<3F4C8424.3040204@aitel.hist.no> <20030827031534.29b08946.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
>>test4-mm1 with the same config works on the same machine,
>> and mounts root between "md: ... autorun DONE" and  "Mounted devfs on /dev"
>>
>> Root is supposed to be on the raid array, which did come up.
>> Lilo uses append="root=/dev/md/0".
> 
> 
> Does reverting this fix it?
> 
> 
Thanks, that did the trick.  Seems this "no root" stuff
didn't realize that I want a root after all.

 > This patch allows a person to not require mounting a root device at 
startup.
 > This works idealy for people trying to use the initramfs/sysfs as the 
only
 > filesystem.
 > What happens is that when the root device is set to 0,0 mount_root is 
not
 > called.

There is more than one way to specify a root, it seems.  I never
set any numbers for my root, I use the root=/dev/md/0 parameter
to the kernel.  I don't have any initramfs.

Why don't those who want to keep an initramfs simply
specify root=/dev/root which don't need extra parsing?

Helge Hafting



