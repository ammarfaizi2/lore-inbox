Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUBIRYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUBIRYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:24:12 -0500
Received: from terminus.zytor.com ([63.209.29.3]:17559 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265273AbUBIRYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:24:10 -0500
Message-ID: <4027C22E.2030409@zytor.com>
Date: Mon, 09 Feb 2004 09:23:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
References: <c07c67$vrs$1@terminus.zytor.com.suse.lists.linux.kernel>	<c07i5r$ctq$1@news.cistron.nl.suse.lists.linux.kernel>	<20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>	<20040209104729.GA19401@traveler.cistron.net.suse.lists.linux.kernel> <p73u120jor1.fsf@verdi.suse.de>
In-Reply-To: <p73u120jor1.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Miquel van Smoorenburg <miquels@cistron.nl> writes:
> 
>>Well, nothing really, but removing BSD style support in the 2.6 series
>>now will break existing installations. Doing it in 2.7 would be fine.
> 
> It will still break existing installations even in 2.7.  And breaking
> early user space is especially nasty to recover from.  Somehow I
> cannot believe keeping them around for compatibility is a unduly
> burden. Please don't remove them.
> 

It's quite possible that their existence block sanitizing the pty code, 
or more specifically, the pty support in the generic tty code.  I'll see 
what I can do about it; it's possible it'll just fall out nicely in the 
end, but I really have no desire to jump through hoops to preserve what 
is a fundamentally broken legancy interface.

	-hpa
