Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTJWKZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTJWKZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:25:04 -0400
Received: from smtp2.email.luna.net ([217.77.137.81]:64660 "EHLO
	smtp2.email.luna.net") by vger.kernel.org with ESMTP
	id S263531AbTJWKZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:25:00 -0400
Message-ID: <3F97AD01.9030806@freemail.hu>
Date: Thu, 23 Oct 2003 12:27:13 +0200
From: Chip <szarlada@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 PROBLEM: codepage=850 doesn't work with mount
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If you've got this line in your /etc/fstab:

/dev/hda5 /mnt/win_d vfat quiet,iocharset=iso8859-1,codepage=850,umask=0 0 0

You will get the following message during mount -a:

mount: wrong fs type, bad option, bad superblock on /dev/hda5,
        or too many mounted file systems

I've chessed out that the problemataic part is the codepage=850. When 
I've removed it the mount goes ok.


My system:
Linux version 2.6.0-test8 (root@localhost) (gcc version 3.2.2 (Mandrake 
Linux 9.1 3.2.2-3mdk)) #3 SMP Mon Oct 20 12:32:45 CEST 2003

After this I've patched my kernel with supermount patch for 2.6.0-test7, 
but doesn't work. After configuring, recompile, and installing I still 
get this message:
mount: fs type supermount not supported by kernel

Please feel free to ask me about these problems and CC me, while I'm not 
on the list.

Kind Regards,
Chip...

