Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTDDUCL (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDDUCL (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:02:11 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:26383 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261351AbTDDUCK convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 15:02:10 -0500
Date: Fri, 4 Apr 2003 22:13:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: =?iso-8859-1?Q?Xos=C9_Vazquez?= <xose@wanadoo.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kbuild(2.4) bug and half solution
In-Reply-To: <3E8DD415.6080507@wanadoo.es>
Message-ID: <Pine.LNX.4.44.0304042211290.12110-100000@serv>
References: <3E8DD415.6080507@wanadoo.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Apr 2003, XosÉ Vazquez wrote:
> -if [ "$CONFIG_PROC_FS" = "y" ]; then
> -   bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
> -fi
> +
> +dep_bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
> $CONFIG_PROC_FS
> +

You can also change this into '[ "$CONFIG_PROC_FS" != "n" ]', so this 
would also work for the choice option.

bye, Roman

