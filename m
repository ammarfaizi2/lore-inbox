Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262971AbTCLAO2>; Tue, 11 Mar 2003 19:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261730AbTCLAMt>; Tue, 11 Mar 2003 19:12:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31681
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261729AbTCLAMb>; Tue, 11 Mar 2003 19:12:31 -0500
Subject: Re: Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in tty_open
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <45750000.1047426594@flay>
References: <45750000.1047426594@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047432641.20681.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 01:30:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 23:49, Martin J. Bligh wrote:
> I'm getting lots of these messages whilst running big SDET runs on
> an 16-way machine ... anyone recognize them?
> (64-bk3 + a few patches).
> 
> dev (pts(136,0)) tty->count(4) != #fd's(3) in release_dev
> Warning: dev (pts(136,0)) tty->count(4) != #fd's(3) in tty_open
> Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in tty_open
> Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in release_dev

These are some of the things I saw when reporting the tty races and
doing zillions of open/closes on pty/tty pairs. The tty layer has
some fun code dealing with open v close v hangup v vhangup

