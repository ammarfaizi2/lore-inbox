Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUHIWTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUHIWTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUHIWTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:19:14 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:11733 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S267313AbUHIWS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:18:57 -0400
Message-ID: <4117F831.90202@timesys.com>
Date: Mon, 09 Aug 2004 18:18:25 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
CC: Tom Rini <trini@kernel.crashing.org>,
       Kumar Gala <kumar.gala@freescale.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Greg Weeks <greg.weeks@timesys.com>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com> <20040809165650.GA22109@smtp.west.cox.net> <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com>
In-Reply-To: <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Malek wrote:

>
> On Aug 9, 2004, at 12:56 PM, Tom Rini wrote:
>
>> Has anyone had a problem with this?  If not, I'll go and pass it
>> along...
>
>
> The default rounding mode should be whatever is defined
> by IEEE.  I thought the emulator used the proper default value
> and if want something different it should be selected by
> the control register.  Maybe the emulator isn't implementing
> the control register properly.
>
> Thanks.
>
>     -- Dan


The submitted patch changing the default rounding mode
caused several regressions in the LSB suite, so it was
NOT the correct fix.

Greg made a finer-grained change which seems to have
made LSB happy.  Unfortunately, he's on vacation this
week, or I'd have him submit the patch he finally used.

I THINK he changed the rouding mode only for a single
corner case in the normalization macro, but that's
about all I remember...

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig


