Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVBWNDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVBWNDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 08:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVBWNDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 08:03:34 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:42245 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261481AbVBWNDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 08:03:30 -0500
Message-ID: <421C7FC2.1090402@aitel.hist.no>
Date: Wed, 23 Feb 2005 14:06:10 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
References: <20050223014233.6710fd73.akpm@osdl.org>
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel came up, but my boot script complained about no /dev/hdb3
when trying to mount /var.
(I have two IDE disks on the same cable, and an IDE cdrom on another.)
They are usually hda, hdb, and hdc.

MAKEDEV hdq did not help.  Looking at sysfs, it turns out that
/dev/hdq1 is at major:3 minor:1025 if I interpret things right. 
(/dev/hda1 is at 3:1, which is correct.)
These numbers did not work with my mknod, it created 7:1 instead.
So I didn't get to test this mysterious device.

But I assume this is a mistake of some sort, I haven't heard about any
change in the IDE numbering coming up?  2.6.1-rc3-mm1 works as expected.

It may be interesting to note that my root raid-1 came up fine,
consisting of hdq1 and hda1 instead of the usual hdb1 and hda1.

Helge Hafting
