Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314380AbSD0Sqo>; Sat, 27 Apr 2002 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSD0Sqn>; Sat, 27 Apr 2002 14:46:43 -0400
Received: from ns.suse.de ([213.95.15.193]:13330 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314380AbSD0Sqm>;
	Sat, 27 Apr 2002 14:46:42 -0400
Date: Sat, 27 Apr 2002 20:46:42 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.10-dj1
Message-ID: <20020427204641.S14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427030823.GA21608@suse.de> <Pine.NEB.4.44.0204272030430.3103-200000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 08:34:47PM +0200, Adrian Bunk wrote:
 > Hi Dave,
 > 
 > there are changes in the 2.5.10-dj1 patch that aren't in the 2.5.9-dj1
 > patch that include removals of defines for TIMEOUT_VALUE and
 > DEVICE_REQUEST that seem to cause the following compile error:

oops, accidentally dropped that when merging Martins updates.

add a #define TIMEOUT_VALUE  (6*HZ) to hd.c
Also you should change..

-   blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &hd_lock);
+   blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_hd_request, &hd_lock);

At line 830 or so.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
