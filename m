Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280678AbRKFXP7>; Tue, 6 Nov 2001 18:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280672AbRKFXPt>; Tue, 6 Nov 2001 18:15:49 -0500
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:22967
	"EHLO janus") by vger.kernel.org with ESMTP id <S280671AbRKFXPl>;
	Tue, 6 Nov 2001 18:15:41 -0500
Message-ID: <3BE87C46.3050500@gutschke.com>
Date: Wed, 07 Nov 2001 01:11:50 +0100
From: Stephan Gutschke <stephan@gutschke.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE870EF.2080508@gutschke.com> <20011106155934.B12661@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sure i try a patch no problem. Especially because my Clie just did a 
hard-reset :-( -- no clue why --  But I am glad when the syncing works
again so i can get my data back on ;-)

See you later
Stephan

Greg KH wrote:

> On Wed, Nov 07, 2001 at 12:23:27AM +0100, Stephan Gutschke wrote:
> 
>>there you go,  the output from  /proc/bus/usb/devices
>>By the way I have an Clie N710C which is upgraded
>>to an 760 with OS 4.1S, shouldnt make a difference,
>>but I just wanted to let you know.
>>
> 
> Ah, that might make the difference.  It looks like the number of
> endpoints is different on this device, than any other 4.x Clie devices
> (they should have 4 bulk endpoints.)  The older devices have 2 endpoints
> (endpoints are usually done in hardware)
> 
> This Clie is reporting to the driver that it _does_ have 2 "ports" (a
> port is 2 endpoint pairs in this scheme), but in reality, it doesn't.
> The lying device is then causing the driver to oops when it tries to
> write to a port that isn't even there.
> 
> I'm going to have to rework the driver to fix this problem, give me a
> day or so to come up with a solution.  Are you willing to try a patch
> when I have something?
> 
> Thanks for the good error reporting, it really helped.
> 
> greg k-h
> 



-- 
Stephan Gutschke

