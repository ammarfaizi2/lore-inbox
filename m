Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbSJOG4n>; Tue, 15 Oct 2002 02:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbSJOG4m>; Tue, 15 Oct 2002 02:56:42 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:8630 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263173AbSJOGzZ>;
	Tue, 15 Oct 2002 02:55:25 -0400
Message-ID: <3DABBD3A.2000901@candelatech.com>
Date: Tue, 15 Oct 2002 00:01:14 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
References: <288F9BF66CD9D5118DF400508B68C44604758B78@orsmsx113.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
>>Here is the lspci information, both -x and -vv.  This is with 
>>two of the e1000 single-port NICS side-by-side.  I have also 
>>strapped a P-IV CPU fan on top of the two cards to blow some 
>>air over them....running tests now to see if that actually 
>>helps anything.  If it does, I'll be sure to send you a picture :)
> 
> 
> Ben, I checked the datasheet for the part shown in the lspci dump, and it
> shows an operating temperature of 0-55 degrees C.  You said you measured 50
> degrees C, so you're within the safe range.  Did the fans help?

The fan did help, and Andi is right, the chip was much hotter than what
my probe read (I was gently pushing it against the top of the chip, cause it
was too hot to really press my finger against it to get good contact :))

With the fan blowing on the chips, it has been perfect.  This implies to me
that if you are going to run the e1000, you need significant air-flow over
the chipset, and the generic 2U chassis that I have is definately inadequate,
partially because the MB is so big that the fans are too far away from the
PCI slots...  This is all doubly true if you are running two NICs side-by-side,
which is what I was doing.

I am also considering glueing heat-sinks onto the main chip, which may make it
work in more marginal environments.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


