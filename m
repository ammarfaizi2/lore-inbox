Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbTFNUDM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbTFNUDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:03:11 -0400
Received: from [66.155.158.133] ([66.155.158.133]:33923 "EHLO
	ns.waumbecmill.com") by vger.kernel.org with ESMTP id S265724AbTFNUDE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:03:04 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: massive file system corruption after loading dhcp,bind,qpopper, and sendmail
Date: Sat, 14 Jun 2003 17:15:23 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306141715.23702.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have several machines deployed with identical Debian Woody distros and 
2.4.19 kernel.  I send these boxes out after following a written load & build 
procedure and master cdrom built from a gold standard.  They all have a 
single 40 GB ide for the system/os drive, and a Promise or 3ware 2x ide raid 
controller with 2 striped ide drives. I use ReiserFS all around. When a 
location needs business continuity services (sendmail, dhcp, bind, and 
qpopper), I apt-get'em and then follow up with a "apt-get update" and 
"apt-get upgrade". This has worked well over the last year.  However, this 
last 30 days, I had a couple of machines that I upgraded with this procedure, 
and within hours I started getting massive reiserfs errors on the system 
drive and if rebooted, won't come all the way up - getting stuck trying to 
load some module.  If I boot off of my recovery CDROM and "reiserfsck 
--fix-fixable /dev/hda2" (hda2 is where I am mounted) I get tons of errors.   

On a hunch I followed the procedure to build a fresh system, but downloaded 
2.4.21 and built it with the same .config file as my 2.4.19,  and installed 
this before getting the downloads (dhcp, bind, ...).  Problem dissappeared!

Is is possible that one or more of those .deb files where built within the 
last 30 days or so, and has some very bad problem?


-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
