Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSG2Rmb>; Mon, 29 Jul 2002 13:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317551AbSG2RmZ>; Mon, 29 Jul 2002 13:42:25 -0400
Received: from imo-m03.mx.aol.com ([64.12.136.6]:28620 "EHLO
	imo-m03.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317543AbSG2RlW>; Mon, 29 Jul 2002 13:41:22 -0400
Message-ID: <3D454763.5050903@netscape.net>
Date: Mon, 29 Jul 2002 13:47:15 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: mochel@osdl.org, rgooch@atnf.csiro.au
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
References: <3D445C2F.20603@netscape.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention:
-    the floppy driver was converted as an example
-    adds a new file "dev" to each driverfs entry
-    output is in the following format
        MAJOR,MINOR PATH
-    one line per each devfs entry during output
-    to test try: #cat (driverfs)/root/sys/03?0/dev
        assuming you have a floppy drive
-    Applies cleanly to 2.5.29 as well
-    If there's a demand for it I'll add the ability to unregister
        individual devfs entries from driverfs
Cheers,
ambx1

ambx1@netscape.net wrote:

> This patch integrates driverfs and devfs.  A summary is as follows:
> - create new interface directory and move interface.c
>       * I intend to add more to this directory later
> - add devfs entry list
> - add devfs related functions
> - create devfs interface
>    This patch is intended to be as non intrusive as possible.  Therefore
> it doesn't modify devfs directly but instead creates a layer above it.
> This is due to the fact that if devfs was modified it would break
> every driver.  Eventually we have to decide when and how to
> integrate it directly,  This patch will provide the necessary
> infrastructure.  Please Apply.
> cheers,
> Adam Belay


