Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUJFPwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUJFPwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbUJFPv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:51:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:18842 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269311AbUJFPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:51:46 -0400
Date: Wed, 6 Oct 2004 17:51:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-ID: <20041006155145.GB10153@wohnheim.fh-wedel.de>
References: <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be> <20041006121534.GA8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be> <20041006133310.GD8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061548390.20160@waterleaf.sonytel.be> <20041006141231.GA6394@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061619460.20160@waterleaf.sonytel.be> <20041006152848.GA10153@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061731480.20160@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410061731480.20160@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: geert@linux-m68k.org, willy@w.ods.org, vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 17:36:17 +0200, Geert Uytterhoeven wrote:
> 
> OK, so you want /dev/console to fall back to /dev/null, right?

In short, yes.  I want fds 0, 1 and 2 to be open for any userspace
process on startup.  That's partly init's job, partly also the
kernel's job.  And /dev/null is a sane fallback.

> Anyway, I should cook up a patch so the /dev/console demux walks the list if
> the one at the head of the list doesn't do input (read: it has no associated
> tty struct).

Good.

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
