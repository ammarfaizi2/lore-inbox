Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVLOSOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVLOSOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVLOSOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:14:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16058 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750827AbVLOSOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:14:07 -0500
Date: Thu, 15 Dec 2005 18:14:05 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051215181405.GB27946@ftp.linux.org.uk>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151832270.1609@scrub.home> <20051215175536.GA27946@ftp.linux.org.uk> <Pine.LNX.4.62.0512151858100.6884@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512151858100.6884@pademelon.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 07:00:54PM +0100, Geert Uytterhoeven wrote:
> Even if behavior is unchanged, this doesn't mean that people like their code
> being modified behind their back...
> 
> Anyway, last time I tried to bring this up with the union of Mac and PowerMac
> guys, no one seemed to remember why ADBREQ_RAW was really needed...

>From my reading of the code it's a way for mac/misc.c to send a packet that
starts with CUDA_PACKET or PMU_PACKET instead of ADB_PACKET, but otherwise
is the same as normal adb_request() ones...

Used for access to timer, nvram, etc. - looks like that puppy used to
use the same protocol for more than just ADB and the first byte of packet
really selects the destination...
