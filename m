Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTL3HDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTL3HDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:03:14 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:31826 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264457AbTL3HDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:03:12 -0500
Message-ID: <3FF1232E.3070401@sbcglobal.net>
Date: Tue, 30 Dec 2003 01:03:10 -0600
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cablespeed.com>
CC: Norman Diamond <ndiamond@wta.att.ne.jp>, dan@eglifamily.dnsalias.net,
       linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
References: <007101c3cdbc$046a58d0$2fee4ca5@DIAMONDLX60> <Pine.LNX.4.58.0312291741530.5409@localhost.localdomain> <00d401c3ce7a$a302fd80$98ee4ca5@DIAMONDLX60> <Pine.LNX.4.58.0312292137100.6639@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0312292137100.6639@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Molina wrote:

>On Tue, 30 Dec 2003, Norman Diamond wrote:
>
>  
>
>> ...
>
>
>I've had problems at various times during 2.5 with a number of 
>card-specific framebuffer drivers so I've backed off to only using the 
>VESA framebuffer driver.  Maybe the connection is which framebuffer driver 
>is used.
>  
>

I've had the same problem.  I've tried using radeonfb and it's never 
worked yet since 2.5.69.  In 2.6.0, no matter what mode I select, I get 
a horizontal frequency of 140kHz and a ~90Hz vertical sync.  My monitor 
blanks and pops up the on-screen menu with the horizontal frequency 
high-lighted in red.  My monitor supports up to 110kHz horizontal 
according to my X log.

I compiled just the vesafb in as well, but it does the exact same 
thing.  It doesn't matter what values or modes I put in the vga/video 
parameter.  Only the text mode works now, and after only 2 days uptime 
I've noticed I no longer have the full vertical screen.  When I type, 
random text or colored/flashing blocks appear in the bottom (roughly) 
1/5th of the screen.  Actually, anytime I run an ncurse app in my 
console, it gets smaller.  Now my console only occupies 1/2 the screen, 
but it doesn't seem to get any smaller than that.  I'm using the boot 
parameter "vga=0x132".

My point is maybe your screen isn't blank, but rather the horizontal 
frequency is out of your monitor's range?

Certainly, something has changed, because with 2.6.0-test11 I was 
running "vga=0x31B video=vesafb:ywrap" and it worked great, whereas now 
it doesn't work at all with any fb modes.


-Wes-
