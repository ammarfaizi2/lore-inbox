Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRCZQmX>; Mon, 26 Mar 2001 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132477AbRCZQmE>; Mon, 26 Mar 2001 11:42:04 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:51244 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132476AbRCZQlu>; Mon, 26 Mar 2001 11:41:50 -0500
Message-ID: <3ABF70B9.573C2F85@sgi.com>
Date: Mon, 26 Mar 2001 08:39:21 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: 64-bit block sizes on 32-bit systems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I vaguely remember a discussion about this a few months back.
If I remember, the reasoning was it would unnecessarily slow
down smaller systems that would never have block devices in
the 4-28T range attached.  

However, isn't it possible there will continue to be a series
of P-IV,V,VI,VII ...etc, addons that will be used for sometime
to come.  I've even heard it suggested that we might see
2 or more CPU's on a single chip as a way to increase cpu
capacity w/o driving up clock speed.  Given the cheapness of
.25T drives now, seeing the possibility of 4T drives doesn't seem
that remote (maybe 5 years?).  

Side question: does the 32-bit block size limit also apply to 
RAID disks or does it use a different block-nr type?

So...is it the plan, or has it been though about -- 'abstracting'
block numbes as a typedef 'block_nr', then at compile time
having it be selectable as to whether or not this was to
be a 32-bit or 64 bit quantity -- that way older systems would
lose no efficiency.  Drivers that couldn't be or hadn't been
ported to use 'block_nr' could default to being disabled if
64-bit blocks were selected, etc.

So has this idea been tossed about and or previously thrashed?

-l

-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
