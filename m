Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVBVLS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVBVLS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 06:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVBVLS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 06:18:58 -0500
Received: from mta13.adelphia.net ([68.168.78.44]:50149 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S262266AbVBVLS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 06:18:57 -0500
Message-ID: <421B14A8.3000501@nodivisions.com>
Date: Tue, 22 Feb 2005 06:16:56 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu> <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no>
In-Reply-To: <421B12DB.70603@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> The infrastructure for that does not exist, so instead, the "killed" 
> process remains. Not all of it, but at least the memory pinned down by 
> the io request.  This overhead is typically small, and the overehad of 
> adding forced io abort to every driver might
> be larger than a handful of stuck processes.  It looks ugly, but perhaps 
> a ps flag that hides the ugly processes is enough.

I don't care about any overhead associated with stuck processes, nor do I 
care that they look ugly in the ps output.  What I care about is the fact 
that at least once a week on multiple systems with different hardware, some 
HW-related driver/process gets stuck, then immediately cascades its 
stuckness up to udevd or hald, and then I can't use any of my hardware 
anymore until I reboot.

-Anthony DiSante
http://nodivisions.com/
