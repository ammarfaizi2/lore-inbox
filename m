Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbTGXIL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 04:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270510AbTGXIL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 04:11:29 -0400
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:3310 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S265766AbTGXIL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 04:11:28 -0400
Date: Thu, 24 Jul 2003 09:26:35 +0100
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kurt =?iso-8859-1?Q?H=E4usler?= <Kurt@fub-group.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Accessing serial port from kernel module
Message-ID: <20030724082635.GA18443@axis.demon.co.uk>
References: <8FB92279C69C2944B325B4BD227401790156B8@nt-server.danziger.local> <1058970342.5520.74.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058970342.5520.74.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:25:43PM +0100, Alan Cox wrote:
> The user space only approach is to use pty/tty pairs as things like
> xterm do. This gives you a "terminal/serial" device the other end of
> which is your user space program which can do the conversions it wants
> then talk to a real serial port

In this latter approach is there any way for the user space program to
catch the termios ioctls (eg to set baud rate etc) that the
application does on the tty end of the pty/tty pair?

(I believe the answer is no!  I got half way through writing a pty/tty
replacement driver which passed the relevant ioctls (decoded into
platform independent "change baud rate to 9600" etc) on the tty
in-band to the pty.  I used in-band so this data stream could then be
piped via ssh etc)

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
