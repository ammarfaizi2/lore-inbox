Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWJQBYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWJQBYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 21:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWJQBYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 21:24:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20939 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030209AbWJQBYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 21:24:36 -0400
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
From: Arjan van de Ven <arjan@infradead.org>
To: "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 17 Oct 2006 03:24:29 +0200
Message-Id: <1161048269.3245.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 16:46 -0400, Phetteplace, Thad (GE Healthcare,
consultant) wrote:
> The I/O priority levels available under the CFQ scheduler are
> nice (no pun in intended), but I remember some talk back when
> they first went in that future versions might include bandwidth
> allocations in addition to the 'niceness' style.  Is anyone out
> there working on that?  If not, I'm willing to hack up a proof
> of concept... I just wan't to make sure I'm not reinventing
> the wheel.


Hi,

it's a nice idea in theory. However... since IO bandwidth for seeks is
about 1% to 3% of that of sequential IO (on disks at least), which
bandwidth do you want to allocate? "worst case" you need to use the
all-seeks bandwidth, but that's so far away from "best case" that it may
well not be relevant in practice. Yet there are real world cases where
for a period of time you approach worst case behavior ;(

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

