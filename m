Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283046AbRLDL1m>; Tue, 4 Dec 2001 06:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283053AbRLDL1X>; Tue, 4 Dec 2001 06:27:23 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:49674 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283050AbRLDL1L>; Tue, 4 Dec 2001 06:27:11 -0500
Date: Tue, 4 Dec 2001 11:27:10 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] Re: paride/Config.in and bool vs. mconfig 0.20
Message-ID: <20011204112710.X14028@redhat.com>
In-Reply-To: <20011202172957.A11453@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011202172957.A11453@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sun, Dec 02, 2001 at 05:29:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 05:29:57PM +0100, Matthias Andree wrote:

> I tried to configure 2.4.17pre2 with mconfig 0.20, it said:
> 
> | drivers/block/paride/Config.in: 32: warning: bool command has extra
> | arguments
> 
> And rightly so, bool wants the configuration question and the parameter,
> nothing else.
> 
> Either that needs some dep_ stuff or it has indeed an extra argument, I
> cannot decide which one is correct, so I'm not providing a patch now.

That option really is just a bool.  Here is the fix.

Tim.
*/

--- linux/drivers/block/paride/Config.in.bool	Tue Dec  4 11:23:35 2001
+++ linux/drivers/block/paride/Config.in	Tue Dec  4 11:24:17 2001
@@ -29,7 +29,7 @@
 dep_tristate '    Shuttle EPAT/EPEZ protocol' CONFIG_PARIDE_EPAT $CONFIG_PARIDE
 if [ "$CONFIG_PARIDE_EPAT" != "n" ]; then
   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-    bool '     Support c7/c8 chips (EXPERIMENTAL)' CONFIG_PARIDE_EPATC8 $CONFIG_PARIDE
+    bool '     Support c7/c8 chips (EXPERIMENTAL)' CONFIG_PARIDE_EPATC8
   fi
 fi
 
