Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTJKEdp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 00:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTJKEdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 00:33:45 -0400
Received: from fep02-svc.mail.telepac.pt ([194.65.5.201]:16043 "EHLO
	fep02-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S262013AbTJKEdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 00:33:43 -0400
Message-ID: <3F8787CA.3030607@vgertech.com>
Date: Sat, 11 Oct 2003 05:32:10 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6-test7] [bttv] lots of warning/error messages
References: <200310091729.30465.mbuesch@freenet.de> <20031010090955.GE32386@bytesex.org>
In-Reply-To: <20031010090955.GE32386@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Gerd Knorr wrote:
>>get lots of warning/error messages from the bttv driver.
>>Here are todays messages:
>>
>>Oct  9 15:51:13 lfs kernel: bttv0: skipped frame. no signal? high irq latency?
>>Oct  9 15:57:57 lfs kernel: bttv0: OCERR @ 1fd95000,bits: HSYNC OFLOW OCERR*
> 
> 
> Hmm.  Is the signal good?
> 

[..snip..]

I *had* the same problem. It's was not the signal so I persued the other 
hint: "high irq latency?"

I opened the box and saw the NIC in slot 2 and winTV in slot3 and 
switched them. Never saw this message again :)

In 2.6.0-test7 zapping (a tv viewer) doesn't work in "capture" mode.
-----------------
Console started, stardate Sat Oct 11 05:26:35 2003
Please tell the maintainer about any bugs you find.

Error: capture.c (870) [capture_start]:
Couldn't start capture: no capture format available

Error: callbacks.c (156) [switch_mode]:
[tveng25.c] tveng25_set_capture_format (line 932)
VIDIOC_S_FMT failed: Device or resource busy
-----------------

xawtv doesn't work, in grabdisplay mode, either.

(overlay is fine on both)

They work with 2.6.0-test4, at least.

Any hints on this one? Can I provide more information?

Thanks,
Nuno Silva


