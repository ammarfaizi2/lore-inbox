Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTEKTo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 15:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTEKTo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 15:44:29 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:14994 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261177AbTEKTo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 15:44:28 -0400
Date: Sun, 11 May 2003 21:57:08 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc2 IDE Modular non-compile
Message-ID: <20030511195708.GC5376@louise.pinerecords.com>
References: <20030509064035.4C6612C014@lists.samba.org> <20030509075319.A10102@infradead.org> <20030510102615.GB12431@louise.pinerecords.com> <1052577101.16165.4.camel@dhcp22.swansea.linux.org.uk> <20030511150312.GB5376@louise.pinerecords.com> <1052671379.29920.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052671379.29920.11.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Sul, 2003-05-11 at 16:03, Tomas Szepe wrote:
> > The patch (against 2.4.21-rc2-ac1) is rather large, because it
> > 	o  moves cmd640.c from drivers/ide/pci to drivers/ide, and
> > 	o  deletes cmd640.h as it is no longer used.
> 
> Please dont move cmd640, the drivers dont go in the top ide directory

[CC list trimmed]

I can't seem to get make to build the objects in pci/ before compiling
in the top level ide directory and a cross-directory dependency on
pci/cmd640.o isn't exactly nice. :(  I could use some help, fs/Makefile
does exactly what ide needs (builds objects in fs's subdirs then links them
together with fs/*.o, except for for -y, not -m) but contains no magic
whatsoever as far as I can tell.

T.
