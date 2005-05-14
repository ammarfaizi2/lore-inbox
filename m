Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVENEej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVENEej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 00:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVENEej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 00:34:39 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:61750 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261154AbVENEeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 00:34:23 -0400
Date: Fri, 13 May 2005 22:34:19 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Sync option destroys flash!
In-reply-to: <43UT5-jT-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42857FCB.80606@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <43UT5-jT-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
> I would have though so, but I can say from personal experience that
> SanDisk brand CF cards respond to losing power during a write by producing
> a bad sector.  I had assumed that a sensible implementation would take
> advantage of the out-of-place writing by doing a two-phase commit at
> write time, so writes would be atomic.
> 
> Does anyone know of a CF manufacturer that *does* guarantee atomic writes?
> Obviously, if power is lost during a write, it's not clear whether
> I'll get the old or the new contents, but I want one or ther other and
> not -EIO.
> 
> Given that SanDisk first developed the CompactFlash card, you'd think they'd
> be a fairly reputable brand...

I think it would be a fair bit of work to guarantee this, unless you add 
enough capacitive energy storage or something onboard to ensure that the 
write can complete even if power is lost. Some hard drives have the same 
problem, actually, where a bad sector can be produced if it was being 
written at the time power was lost.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


