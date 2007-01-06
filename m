Return-Path: <linux-kernel-owner+w=401wt.eu-S932092AbXAFTUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbXAFTUR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXAFTUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:20:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37962 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbXAFTUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:20:15 -0500
Message-ID: <459FF60D.7080901@zytor.com>
Date: Sat, 06 Jan 2007 11:18:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: "J.H." <warthog9@kernel.org>, Willy Tarreau <w@1wt.eu>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz>	<20061216094421.416a271e.randy.dunlap@oracle.com>	<20061216095702.3e6f1d1f.akpm@osdl.org>	<458434B0.4090506@oracle.com>	<1166297434.26330.34.camel@localhost.localdomain>	<20061219063413.GI24090@1wt.eu>	<1166511171.26330.120.camel@localhost.localdomain> <20070106103331.48150aed.randy.dunlap@oracle.com>
In-Reply-To: <20070106103331.48150aed.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
>
>>> BTW, yesterday my 2.4 patches were not published, but I noticed that
>>> they were not even signed not bziped on hera. At first I simply thought
>>> it was related, but right now I have a doubt. Maybe the automatic script
>>> has been temporarily been disabled on hera too ?
>> The script that deals with the uploads also deals with the packaging -
>> so yes the problem is related.
> 
> and with the finger_banner and version info on www.kernel.org page?

Yes, they're all connected.

The load on *both* machines were up above the 300s yesterday, probably 
due to the release of a new Knoppix DVD.

The most fundamental problem seems to be that I can't tell currnt Linux 
kernels that the dcache/icache is precious, and that it's way too eager 
to dump dcache and icache in favour of data blocks.  If I could do that, 
this problem would be much, much smaller.

	-hpa
