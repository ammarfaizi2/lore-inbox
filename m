Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUJUUsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUJUUsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUJUUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:48:28 -0400
Received: from [69.4.201.55] ([69.4.201.55]:56704 "EHLO bitworks.com")
	by vger.kernel.org with ESMTP id S268778AbUJUUry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:47:54 -0400
Message-ID: <41782070.4070303@bitworks.com>
Date: Thu, 21 Oct 2004 15:47:44 -0500
From: Richard Smith <rsmith@bitworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video
 card BOOT?
References: <41764FB3.29782.1B9A13F4@localhost> <4177AD6B.23151.20F0292D@localhost>
In-Reply-To: <4177AD6B.23151.20F0292D@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

>>One more question: Does 0xc0000 POST method work even on
>>notebooks? On regular machines, PCI card must have normal bios and
>>stuff is easy. On notebooks there was talk about "integrated bios"
>>where it really has no video bios at all and system bios POSTs the
>>card. Have you seen that? 

With all the video chips I've worked with the mfg gives me a binary 
formatted up as an option ROM and I'm responsible for getting it called.

> We have never had a need to POST a notebook Video BIOS so I don't know 
> what would happen. It is an interesting question, and if this is to be 
> used for resume operations something that should be investigated.
> 

What I've seen is that they simply place a copy of the video bios at the 
shadowed legacy vbios range usually 0xc0000 but it can be anywhere in 
the 0xc0000-0x0e0000 range.  Or physically locate the vbios in the 
onboard ROM such that it will show up in that range.

Then when the system bios goes through its scan of the legacy ranges 
looking for option roms it hits the video bios and runs it.

-- 
Richard A. Smith


