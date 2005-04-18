Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVDRXOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDRXOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 19:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDRXOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 19:14:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24543 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261158AbVDRXOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 19:14:39 -0400
Subject: Re: Garbage on serial console after serial driver loads
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Slootman <paul+nospam@wurtel.net>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <d3j49v$u2j$1@news.cistron.nl>
References: <20050325202414.GA9929@dreamland.darkstar.lan>
	 <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr>
	 <20050326151005.D12809@flint.arm.linux.org.uk>
	 <20050326155549.GA5881@linuxace.com>  <d3j49v$u2j$1@news.cistron.nl>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 09:14:14 +1000
Message-Id: <1113866055.3579.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 12:45 +0000, Paul Slootman wrote:
> Phil Oester  <kernel@linuxace.com> wrote:
> >On Sat, Mar 26, 2005 at 03:10:05PM +0000, Russell King wrote:
> >> Doesn't matter.  The problem is that dwmw2's NS16550A patch (from ages
> >> ago) changes the prescaler setting for this device so we can use the
> >> higher speed baud rates.  This means any programmed divisor (programmed
> >> at early serial console initialisation time) suddenly becomes wrong as
> >> soon as we fiddle with the prescaler during normal UART initialisation
> >> time.

Hmm. Why aren't we recalculating the divisor when we change the
prescaler? This used to work for serial consoles at the time -- even for
serial consoles about 115200 baud, IIRC. 

-- 
dwmw2

