Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWH1TSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWH1TSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWH1TSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:18:32 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:37300 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751376AbWH1TSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:18:31 -0400
Date: Mon, 28 Aug 2006 15:18:29 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200 system
Message-ID: <20060828191829.GO13639@csclub.uwaterloo.ca>
References: <20060825203047.GH13641@csclub.uwaterloo.ca> <1156540817.3007.270.camel@localhost.localdomain> <20060825210305.GL13639@csclub.uwaterloo.ca> <20060825212441.GC2246@martell.zuzino.mipt.ru> <20060825215724.GI13641@csclub.uwaterloo.ca> <20060828181141.GK13641@csclub.uwaterloo.ca> <1156792178.6271.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156792178.6271.46.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 08:09:38PM +0100, Alan Cox wrote:
> That is worth fixing.

Well changing

case 4:

to

case 4:
case 11:
	dir0_msn = 4;

Makes the geode code appear to be called, and nothing is broken so
far.  Minimal testing so far actually seems to indicate a slight
performance improvement.  And /proc/cpuinfo no longer shows Unknown
model.  I am pretty sure in the past I have seen the model name show
MediaGX, so I suspect sometime in the last year there was a revision
change or something in the cpu modules we are using, since it now shows
Unknown.

> The databook is available from www.amd.com I believe. You'd need to look
> at that and see what needs setting. It is quite similar so it probably
> will benefit a little - but that also depends what the BIOS does for you
> and with ACPI that should be handled by the ACPI.

This BIOS has no ACPI.  At best it could do APM.

Seems the amd site requires an NDA to get at anything useful.  Maybe I
looked in the wrong place.

--
Len Sorensen
