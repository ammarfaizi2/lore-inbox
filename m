Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSKBVhK>; Sat, 2 Nov 2002 16:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSKBVhK>; Sat, 2 Nov 2002 16:37:10 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39819 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261454AbSKBVhJ>; Sat, 2 Nov 2002 16:37:09 -0500
Subject: Re: swsusp: don't eat ide disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021102202504.GD18576@atrey.karlin.mff.cuni.cz>
References: <20021102184735.GA179@elf.ucw.cz>
	<200211022006.gA2K6XW08545@devserv.devel.redhat.com> 
	<20021102202504.GD18576@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 22:04:33 +0000
Message-Id: <1036274673.16803.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 20:25, Pavel Machek wrote:
> > Some disks are going to be settint their own power methods too.
> 
> Fine with me as long as they call idedisk_suspend() first ;-).

They may or may not do so depending upon other considerations. The new
driver layer is supposed to handle suspend/power ordering. If it doesn't
then it needs fixing. You can't go around hacking weird suspend shit
into every single block driver for a final system, sure for a prototype
but not the real thing. No way

