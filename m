Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbUIFPpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbUIFPpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268161AbUIFPpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:45:35 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:65296 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S268159AbUIFPpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:45:31 -0400
Message-ID: <413C8612.4010806@superbug.demon.co.uk>
Date: Mon, 06 Sep 2004 16:45:22 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Danny ter Haar <dth@ncc1701.cistron.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux serial console patch
References: <20040905175037.O58184@cus.org.uk> <413BA35C.8080705@superbug.demon.co.uk> <chhebr$pta$1@news.cistron.nl> <20040906114321.A26906@flint.arm.linux.org.uk>
In-Reply-To: <20040906114321.A26906@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Sep 06, 2004 at 10:32:27AM +0000, Danny ter Haar wrote:
> 
>>James Courtier-Dutton  <James@superbug.demon.co.uk> wrote:
>>
>>>>I have read your posts to lkml containing your serial console flow control
>>>>patches firstly for 2.4.x and then for 2.6.x kernels.
>>>
>>>Does this fix junk being output from the serial console?
>>>If one is using Pentium 4 HT, it seems that both CPU cores try to send 
>>>characters to the serial port at the same time, resulting in lost 
>>>characters as one CPU over writes the output from the other.
>>
>>We have multiple P4-HT enabled servers with debian installed & serial
>>console enabled (RPB++ ;-) and _i_ have never seen this behaviour.
> 
> 
> I don't think this is a serial problem as such, but a problem with the
> kernel console subsystem (printk) itself.  Maybe James can provide an
> example output to confirm exactly what he's seeing.
> 

http://www.superbug.demon.co.uk/latency/

There are 2 oops traces there. At about line 176, the corruption starts.

