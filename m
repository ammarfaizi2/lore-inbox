Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUC1QzW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUC1QzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:55:22 -0500
Received: from mxsf27.cluster1.charter.net ([209.225.28.227]:26886 "EHLO
	mxsf27.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261996AbUC1QzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:55:15 -0500
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
From: Glenn Johnson <glennpj@charter.net>
To: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1080490657.9667.7.camel@gforce.johnson.home>
References: <1080435375.8280.1.camel@gforce.johnson.home>
	 <20040327180932.10e4bae7.akpm@osdl.org>
	 <1080443802.7085.2.camel@gforce.johnson.home>
	 <20040328090637.GA11056@elte.hu>
	 <1080490657.9667.7.camel@gforce.johnson.home>
Content-Type: text/plain
Message-Id: <1080492821.7578.5.camel@gforce.johnson.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 28 Mar 2004 10:53:41 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-28 at 10:17, Glenn Johnson wrote:

> On Sun, 2004-03-28 at 03:06, Ingo Molnar wrote:
> 
> > * Glenn Johnson <glennpj@charter.net> wrote:
> > 
> > > > It could be the AGP changes.  Please do a `patch -p1 -R' of
> > > > bk-agpgart.patch and retest?
> > > 
> > > I reverted that patch and retested but it did not solve the problem. I
> > > am still only seeing about 180 fps with glxgears.
> > 
> > what does 'glxinfo | grep rendering' show?
> 
> It shows:
> 
>         direct rendering: Yes
>         
> I had checked that first thing. I also verified that the AGPgart
> detected the chipset, etc. Everything seems okay in the XFree86 log file
> as well.

I just did a diff of my XFree86 log files with the system booted using
the 2.6.5-rc2-mm2 and 2.6.5-rc2-mm4 kernels, respectively. Here is the
diff, so maybe this will mean something.

--- XFree86-2.6.5-rc2-mm2.log	2004-03-28 10:32:00.070254034 -0600
+++ XFree86-2.6.5-rc2-mm4.log	2004-03-28 10:29:30.123163884 -0600
@@ -19 +19 @@
-(==) Log file: "/var/log/XFree86.0.log", Time: Sun Mar 28 10:31:22 2004
+(==) Log file: "/var/log/XFree86.0.log", Time: Sun Mar 28 10:28:32 2004
@@ -713,2 +713,2 @@
-(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe188b000
-(II) RADEON(0): [drm] mapped SAREA 0xe188b000 to 0x48328000
+(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe1889000
+(II) RADEON(0): [drm] mapped SAREA 0xe1889000 to 0x48328000
@@ -764 +764 @@
-(II) RADEON(0): [drm] dma control initialized, using IRQ 169
+(II) RADEON(0): [drm] dma control initialized, using IRQ 10



--
Glenn Johnson
glennpj@charter.net

