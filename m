Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVGYUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVGYUWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVGYUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:22:47 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16902 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261497AbVGYUUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:20:23 -0400
Message-ID: <42E54A64.7010107@tmr.com>
Date: Mon, 25 Jul 2005 16:24:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Bernd Petrovitsch <bernd@firmix.at>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Puneet Vyas <vyas.puneet@gmail.com>
Subject: Re: xor as a lazy comparison
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>	 <42E4131D.6090605@gmail.com>  <1122281833.10780.32.camel@tara.firmix.at>	 <1122314150.6019.58.camel@localhost.localdomain> <1122318659.1472.14.camel@mindpipe>
In-Reply-To: <1122318659.1472.14.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2005-07-25 at 13:55 -0400, Steven Rostedt wrote: 
> 
>>Doesn't matter. The cycles saved for old compilers is not rational to
>>have obfuscated code.
> 
> 
> Where do we draw the line with this?  Is x *= 2 preferable to x <<= 2 as
> well?

In addition to the obvious error, let's not use x += x as well. If you 
want to multiple by two, do it.

Wasn't there a CPU where multiple was faster than add? Doesn't matter, 
let the compiler make the optimizations so you don't have to.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
