Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263290AbTDCGDX>; Thu, 3 Apr 2003 01:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263293AbTDCGDW>; Thu, 3 Apr 2003 01:03:22 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:13474 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S263290AbTDCGDV>; Thu, 3 Apr 2003 01:03:21 -0500
Message-ID: <3E8BD075.1000709@seme.com.au>
Date: Thu, 03 Apr 2003 14:11:01 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad loses sync 2.5.66
References: <3E8BCB4F.5080900@seme.com.au> <20030403060618.GA28432@triplehelix.org>
In-Reply-To: <20030403060618.GA28432@triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> On Thu, Apr 03, 2003 at 01:49:03PM +0800, Brad Campbell wrote:
> 
>>Under X 4.2.0 (Happened under 4.1.x also) the Touchpad loses sync quite 
>>frequently causing the mouse to go haywire, jumping all over the screen 
>>and sending button presses that I have not made.
>>The exact same configuration works perfectly under 2.4.x
> 
> 
> I talked about this problem on LKML around 2.5.59.

Ahh, that was about when I subscribed, I must have just missed it.

> If you use an ACPI battery monitor (I notice you are on a laptop and
> you have ACPI enabled), there is a lot of Bad Mojo (TM) in psmouse.c
> at the moment. Just don't use it if you have a synaptics touchpad, and
> things should work out immediately.

Well that was interesting.. I started X, told the battery monitor not to 
start on X startup, stopped X and re-started it, and the machine totaly 
hard locked. No Alt-Sysrq, no external ping.. no nothing..

After a hard re-boot, I can confirm that not running the ACPI battery 
monitor solves (works around) the problem. Problem being I now have no 
idea when my battery is going to die :p)

Thanks for the quick response.

-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

