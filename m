Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTD3VGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTD3VGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:06:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30470 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262439AbTD3VGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:06:40 -0400
Message-ID: <3EB03DB0.1080804@zytor.com>
Date: Wed, 30 Apr 2003 14:18:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bootable CD idea
References: <200304301921.h3UJLgCZ001523@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304301921.h3UJLgCZ001523@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> 
> Ah, it makes more sense now :-).  So, could I bodge 2.4 in to working
> by modifying bootsect.S with something like this?
> 
> 
>         movw    $disksizes+1, %si         # Force 18 sectors/track
> probe_loop:
>         lodsb
>         cbtw                            # extend to word
>         xchgw   %cx, %ax                # %cx = track and sector
>         xorw    %dx, %dx                # drive 0, head 0
>         movw    $0x0200, %bx            # address = 512, in INITSEG (%es = %cs)
>         movw    $0x0201, %ax            # service 2, 1 sector
>         int     $0x13
>         movb    $0x03, %ah              # read cursor pos
>         xorb    %bh, %bh
> 
> John.

Perhaps you could, but why the fsck do you want to beat a dead horse
over and over again?  Use a real bootloader instead.

	-hpa

