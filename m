Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTL3FJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTL3FJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:09:45 -0500
Received: from holomorphy.com ([199.26.172.102]:10689 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264463AbTL3FJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:09:44 -0500
Date: Mon, 29 Dec 2003 21:09:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Thomas Molina <tmolina@cablespeed.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230050934.GM27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Thomas Molina <tmolina@cablespeed.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain> <1072739685.25741.65.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072739685.25741.65.camel@nosferatu.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 00:58, Thomas Molina wrote:
>> It certainly looks like DMA is enabled.  Under 2.4 I get:
>> [root@lap root]# hdparm /dev/hda
[...]
>>  readahead    =  8 (on)
[...]
>> Under 2.6  I get:
>> [root@lap root]# hdparm /dev/hda
[...]
>>  readahead    = 256 (on)

On Tue, Dec 30, 2003 at 01:14:45AM +0200, Martin Schlemmer wrote:
> Increase your readahead:
>  # hdparm -a 8192 /dev/hda
> BTW:  As we really do get this question a _lot_ of times, why
>       don't the ide layer automatically set a higher readahead
>       if there is enough cache on the drive or something?

Could you try lowering 2.6's readahead to 2.4's levels in order to rule
out readahead-induced thrashing?


-- wli
