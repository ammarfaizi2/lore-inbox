Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRB1SE5>; Wed, 28 Feb 2001 13:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRB1SEr>; Wed, 28 Feb 2001 13:04:47 -0500
Received: from emcmail.lss.emc.com ([168.159.48.78]:22703 "EHLO emc.com")
	by vger.kernel.org with ESMTP id <S129126AbRB1SEg>;
	Wed, 28 Feb 2001 13:04:36 -0500
Message-ID: <3A9D3C9E.6090807@emc.com>
Date: Wed, 28 Feb 2001 12:59:58 -0500
From: Ric Wheeler <ric@emc.com>
Reply-To: ric@emc.com
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.10 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: "David L. Nicol" <david@kasey.umkc.edu>
CC: Zack Brown <zbrown@tumblerings.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cluster@nl.linux.org
Subject: Re: Will Mosix go into the standard kernel?
In-Reply-To: <Pine.LNX.3.96.1010227091255.780M-100000@renegade> <3A9C1A3A.8BC1BCF2@kasey.umkc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two parts of MOSIX that deal with file systems.
In MOSIX, every migrated process leaves a proxy at its creation (home)
node that services all system call requests, including IO calls.

What newer versions of MOSIX did is to add the "DFSA" (direct file
system access) layer that allows MOSIX to support executing file
system calls locally for migrated process when they are against a
cache coherent, cluster file system (think GFS).  When this was put
in MOSIX, they also did a write through, non-caching file system to
test their DFSA code called MFS.

Both the MOSIX team and the global file system group have been involved
in getting their stuff to play nicely together.

ric




