Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270797AbTG0OLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbTG0OLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:11:25 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:26892 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270797AbTG0OLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:11:24 -0400
Date: Sun, 27 Jul 2003 16:26:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: make menuconfig
Message-ID: <20030727142637.GA11649@mars.ravnborg.org>
Mail-Followup-To: Voicu Liviu <pacman@mscc.huji.ac.il>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <3F2391EF.8080707@mscc.huji.ac.il> <20030727100017.GB21246@mars.ravnborg.org> <3F239AE5.9010403@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F239AE5.9010403@mscc.huji.ac.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 12:27:01PM +0300, Voicu Liviu wrote:
> >
> >Works for me. Could you provide exact error-message etc.
> 
> liviu@starshooter liviu $ su
> Password:
> liviu has logged on pts/0 from :0.0.
> liviu has logged on pts/1 from :0.0.
> liviu has logged on vc/1 from local.
> liviu has logged on vc/2 from local.
> starshooter /root# cd /usr/src/linux
> starshooter src/linux# make menuconfig
> Missing }.
> starshooter src/linux#

Too little context to determine where it goes wrong.
I tried with tcsh here with success.

Try the followings steps:

1) Do not compile as root. In general does as little as possible as root.
Only the kernel installlation requires root priviliges.

2) Try to run "make -n", that may hint where is goes wrong.

3) Do not locate the kernel src in /usr/src/linux - it will conflict with
glibc header files. No matter what a HOWTO say otherwise.

4) Try another shell, for instance bash.
Not that the kernel build should rely on bash only, but an approach to
get your kernel to compile.

	Sam
