Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVHaRC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVHaRC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVHaRC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:02:29 -0400
Received: from styx.suse.cz ([82.119.242.94]:49058 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964883AbVHaRC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:02:28 -0400
Date: Wed, 31 Aug 2005 19:02:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mark Lord <mlord@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050831170242.GA11556@midnight.ucw.cz>
References: <20050830093715.GA9781@midnight.suse.cz> <4315E0F0.6060209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4315E0F0.6060209@pobox.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 12:55:12PM -0400, Mark Lord wrote:

> Mmm.. curious sequence in the first 512 bytes of
> the DWL-G730AP firmware binary.  It has this
> sequence of bytes repeated several times:
> 
>   81 40 20 10 08 04 02 81 40 20 10 08 04 02 ...
> 
> That should be recognizable to somebody, I think.

I noticed this already. Might be a beginning of address space, some kind
of table, might be just empty memory padding pattern, or it might be a
trivial obfuscating XOR of the whole binary.

There are no strings until the end, and the binary is quite
compressible, which is very suspicious, and looks more like obfuscation
than compression.

> I'll try loading the works into another ARM
> system I have here, and see (1) if it runs as-is,
> and (2) what the disassembly shows.
> 
> I'd certainly like to get source for my 730AP here,
> as it seems to be a bit buggy on the WEP implementation.

It seems quite buggy in other respects, too, one day it stopped
accepting any packets through the WiFi interface, even after factory
reset. The WiFi did work, though, I could associate, etc. The other side
worked too. But no data. Then, another day, all was OK again.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
