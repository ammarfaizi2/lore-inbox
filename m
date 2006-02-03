Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945954AbWBCU4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945954AbWBCU4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945958AbWBCU4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:56:35 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:24477 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1945954AbWBCU43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:56:29 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Alexander Fieroch <fieroch@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16rc2] compile error
References: <ds08vk$hk$1@sea.gmane.org> <87d5i48dxg.fsf@sycorax.lbl.gov>
	<ds0ce1$dma$1@sea.gmane.org>
Date: Fri, 03 Feb 2006 12:56:28 -0800
In-Reply-To: <ds0ce1$dma$1@sea.gmane.org> (message from Alexander Fieroch on
	Fri, 03 Feb 2006 20:54:41 +0100)
Message-ID: <87vevw6u0z.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Fieroch wrote:

> Alex Romosan wrote:
>> look at /dev/null. on my system it keeps getting replaced by a regular
>> file. not really sure where the bug is, but 'cd /dev; ./MAKEDEV null'
>> will recreate the null character device and then the compilation will
>> proceed normally.
>> 
>> --alex--
>
> Thanks, that's it. /dev/null was replaced by a regular file.
> Hm, /dev/MAKEDEV null and /dev/MAKEDEV std didn't rebuild the character
> device null... but a reboot did.

you are probably running udev or something like that which generates
the devices automagically...

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
