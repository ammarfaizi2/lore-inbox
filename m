Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbSKDWXk>; Mon, 4 Nov 2002 17:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSKDWXk>; Mon, 4 Nov 2002 17:23:40 -0500
Received: from zeke.inet.com ([199.171.211.198]:52615 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S262814AbSKDWXi>;
	Mon, 4 Nov 2002 17:23:38 -0500
Message-ID: <3DC6F4F3.5010801@inet.com>
Date: Mon, 04 Nov 2002 16:30:11 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: landley@trommello.org
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
References: <20021030233605.A32411@jaquet.dk> <20021104195005.GB27298@opus.bloom.county> <20021104133420.E20427@duath.fsmlabs.com> <200211041616.48602.landley@trommello.org>
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=_IS_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rob Landley wrote:
> On Monday 04 November 2002 20:34, Cort Dougan wrote:
> 
>>I'm with you on that.  People who clammer ignorantly about image size
>>without looking at what they actually need should have opened their eyes in
>>the last few years.  Flash and RAM sizes under 32M are nearly unheard of
>>now-a-days.
> 
> 
> How much power does flash eat?  I was under the impression half the reason for 
> tiny amounts of memory was to increase battery life in things that really 
> should last weeks or months instead of hours (wristwatches, cell phones on 
> standby, etc), but I guess that's mostly a question of dram and sram, not 
> flash.  (I take it you can read the heck out of it without wearing it out, 
> it's just writes that are a problem...  Then again you don't want rapidly 
> rewritten bookkeeping stuff in flash, do you?  (Jiffies, scheduler stuff, 
> etc, should not be in flash...))

There a couple of kinds of flash memory that have different properties 
in the writes...
The one I'm more familiar with allows you to change any '1' bit to a '0' 
bit on a bit-by-bit basis, but it is, ehm, a tad slow.  But if you want 
to change a '0' bit to a '1' bit, you have to erase a 16 or 32 kB block 
to all '1' bits, and that is, well, very slow.
(Storing 'jiffies' in flash, given that updating the jiffies would take 
multiple jiffies would be, well, 'fun'. ;) I could, however, see some 
sense in running the read-only parts of the kernel directly from flash...)
It's been a while since I looked at read times, but I expect it to be 
essentially memory speeds.

 > Not my area, I'm afraid...
 >
 > Rob

Just an FYI, in case you're curious.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

--=_IS_MIME_Boundary
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

---------------------------------------------------------

Confidentiality Notice:    This e-mail transmission may contain
confidential and/or privileged information that is intended only for 
the individual or entity named in the e-mail address.  If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution or reliance upon the contents of this e-mail
message is strictly prohibited. If you have received this e-mail
transmission in error, please reply to the sender, so that proper
delivery can be arranged, and please delete the message from your
computer.  Thank you.
Inet Technologies, Inc.

---------------------------------------------------------

--=_IS_MIME_Boundary--
