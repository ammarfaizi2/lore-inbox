Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbTLMXT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 18:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265313AbTLMXT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 18:19:58 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:506 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265311AbTLMXT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 18:19:57 -0500
Date: Sat, 13 Dec 2003 23:19:56 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: pprice@cs.mun.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: Writing to NTFS and kernel 2.6-test11
In-Reply-To: <3157.134.153.205.13.1071348202.squirrel@www.cs.mun.ca>
Message-ID: <Pine.SOL.4.58.0312132315440.10369@yellow.csi.cam.ac.uk>
References: <3157.134.153.205.13.1071348202.squirrel@www.cs.mun.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Dec 2003 pprice@cs.mun.ca wrote:
> I have read that it is possible to change a file as long as it is the same
> size using write(2) and mmap(2). I don't seem to be able to make this
> work. I was wondering if someone has some code that will allow me to do
> this. Any input would be greatly appreciated.

Did you compile in read-write support?

What is the message in syslog when NTFS loads? If it is a module then type
"modprobe ntfs" to make sure it is loaded.  If not a module or a module
and you have loaded it just type: dmesg | grep -i ntfs and please tell me
the output you get from that.

Also, note that writes to resident files are not permanent in the driver
in 2.6-test11 (i.e. small files about 500 bytes or so).  They are never
written to disk.  Bigger files >1kb are guaranteed to be written always.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
