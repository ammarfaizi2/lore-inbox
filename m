Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUBSW04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUBSW0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:26:07 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:11935 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S267391AbUBSWZV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:25:21 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Thu, 19 Feb 2004 19:25:18 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org>
Message-ID: <Pine.LNX.4.58.0402191924090.688@pervalidus.dyndns.org>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com>
 <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Frédéric L. W. Meunier wrote:

> Unless I'm missing something, it doesn't seem to work if you
> don't have /dev/null before it gets mounted.
>
> I got
>
> Creating initial udev device nodes:
> /etc/rc.d/start_udev: line 90: cannot redirect standard input from /dev/null: No such file or directory.
>
> and it didn't boot.
>
> My first rc.S lines have:
>
> mount -vn -t proc proc /proc # Needed for LABEL= in /etc/fstab
>
> mount -vn -t sysfs sysfs /sys
>
> /etc/rc.d/start_udev

Sorry, forgot to mention that line 90 is
$udevd &

since I added a
mknod /dev/fb0 c 29 0

just before
run_udev

Is it the right procedure until udev created the frame buffer
devices ?

-- 
http://www.pervalidus.net/contact.html
