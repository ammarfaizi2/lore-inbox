Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTH0PPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTH0PPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:15:37 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:50848 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263431AbTH0PPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:15:36 -0400
Subject: Re: vesafb mtrr setup question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arvind Sankar <arvinds@MIT.EDU>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826155044.GA27105@m66-080-18.mit.edu>
References: <20030825194304.GA14893@m66-080-17.mit.edu>
	 <1061912542.20846.50.camel@dhcp23.swansea.linux.org.uk>
	 <20030826155044.GA27105@m66-080-18.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061997292.22721.47.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 16:14:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-26 at 16:50, Arvind Sankar wrote:
> Ah. On a side not, could you drop a quick hint as to how
> screen_info.lfb_size is obtained?
> 
> In older (or just different?) versions of vesafb, the video_size was
> actually computed by multiplying xres, yres, and the bpp.

The BIOS will provide the size of the LFB. In 2.4 we now work out the
size we need for a sensible amount of scrollback and the like because
the LFB size may be huge (256Mb for example) and we don't want to blow
all our kernel address space on a useless mapping

