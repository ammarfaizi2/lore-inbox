Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbVLFUOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVLFUOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVLFUOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:14:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35278 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932631AbVLFUOS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:14:18 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051205030936.GH15164@ca-server1.us.oracle.com>
References: <43923DD9.8020301@wolfmountaingroup.com>
	 <20051204121209.GC15577@merlin.emma.line.org>
	 <1133699555.5188.29.camel@laptopd505.fenrus.org>
	 <20051204132813.GA4769@merlin.emma.line.org>
	 <1133703338.5188.38.camel@laptopd505.fenrus.org>
	 <20051204142551.GB4769@merlin.emma.line.org>
	 <1133707855.5188.41.camel@laptopd505.fenrus.org>
	 <20051204150804.GA17846@merlin.emma.line.org>
	 <jebqzw50x8.fsf@sykes.suse.de>
	 <20051204161709.GC17846@merlin.emma.line.org>
	 <20051205030936.GH15164@ca-server1.us.oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 20:13:30 +0000
Message-Id: <1133900010.23610.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-12-04 at 19:09 -0800, Joel Becker wrote:
> On Sun, Dec 04, 2005 at 05:17:09PM +0100, Matthias Andree wrote:
> > There are things that old Sun Workshop versions bitch about that GCC
> > deals with without complaining, and I'm not talking about C99/C++-style
> > comments. C standard issue? I believe not.
> 
> 	I have seen many a code like so:
> 
>     char buf[4];
>     memcpy(buf, source, 5);
> 
> accepted by the Sun compilers and run just fine.  When the application
> was ported to Linux/GCC, the developers complained their program
> segfaulted, and "it must be something broken on Linux!"
> 	Just because Sun's compiler does something doesn't mean it's

It isnt the compiler quite often. The usual case is

	char buf[4];
	strcpy(buf, "bits");

And those cases usually work because its a big endian box and the \00
ends up overwriting the \00 in the return address.


