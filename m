Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWJUVKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWJUVKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 17:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbWJUVKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 17:10:34 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41446 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161062AbWJUVKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 17:10:32 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <453A8CA7.5070108@s5r6.in-berlin.de>
Date: Sat, 21 Oct 2006 23:09:59 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference in sysfs_readdir
References: <4539DDC5.80207@s5r6.in-berlin.de> <200610212204.56772.mb@bu3sch.de>
In-Reply-To: <200610212204.56772.mb@bu3sch.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Saturday 21 October 2006 10:43, Stefan Richter wrote:
...
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188140
...
> Looking through the code I was not able to locate the exact line
> at which it oopses, with the above oops message.
> Are you able to track down the exact pointer dereference, which causes
> this? By inserting printks, perhaps.

I need the original reporter to do this since I cannot reproduce the
bug. Probably because I don't have an SMP machine yet.

> Maybe FC changed some of the structures. I couldn't find
> a used structure with an interresting member at offset 00000020, at least.

Could be struct sysfs_dirent.s_dentry if I'm counting correctly in
http://www.linux-m32r.org/lxr/http/source/include/linux/sysfs.h?v=2.6.16#L68
The trace was from 2.6.16.
-- 
Stefan Richter
-=====-=-==- =-=- =-=-=
http://arcgraph.de/sr/
