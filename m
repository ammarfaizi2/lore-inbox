Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTLHTXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTLHTXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:23:32 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:62987 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S261326AbTLHTXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:23:30 -0500
Message-ID: <3FD4D405.2070400@nishanet.com>
Date: Mon, 08 Dec 2003 14:41:57 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: bluefaceplate demographics Re: cdrecord hangs my computer
References: <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org> <br27v2$fdh$1@gatekeeper.tmr.com> <Pine.LNX.4.58.0312080927510.13236@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312080927510.13236@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#/etc/default/cdrecord
#works--
CDR_DEVICE=ATAPI:/dev/bluefaceplate
#ATAPI:1,0,0 not working due to devfs stub diff

but then Joerg's revenge is to gain political leverage
by recruiting neophytes who can't configure options
on the command line(!aliased, !scripted) so they love
Joerg if his default works--and for second-degree
neophytes who can edit config files, default opts config
won't take bluefaceplate(explicit devpath) nomenclature!
--targbuslun only(can ide-cd do this ATAPI:1,0,0?)!--

# drive name    device  speed   fifosize driveropts
#
teac=           1,3,0   -1      -1      ""
panasonic=      1,4,0   -1      -1      ""
plextor=        1,4,0   -1      -1      ""
sanyo=          1,4,0   -1      -1      burnfree
# will ide-cd work here?---
yamaha=   ATAPI:1,0,0   -1      -1      ""
cdrom=          0,6,0    2      1m      ""

-Bob D

Linus Torvalds wrote:

>On Mon, 8 Dec 2003, bill davidsen wrote:
>
>  
>
>>In article <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>,
>>Linus Torvalds  <torvalds@osdl.org> wrote:
>>|
>>| And you liked the fact that you were supposed to write "dev=0,0,0" or
>>| something strange like that? What a piece of crap it was.
>>
>>  Actually, dev=0,0,0 or dev=/dev/hdc are neither particularly portable;
>>each can be something else on another machine. At least /dev/sr0 (or
>>scd0 if you go to that church) are a bit less likely to change.
>>    
>>
>
>Actually, the sane thing to do is to use "/dev/cdrom", which is likely to
>be right, and if it isn't, you can always fix it (and you can fix it
>_dynamically_ with something like "udev" - so it will do the right thing
>even if your cdrom happens to be hot-pluggable).
>
>The only time that ends up being confusing is if you have multiple CD-roms
>(which used to be common - DVD reader and CD writer - but is going away
>again on "normal" machines due to combo drives). And then you really
>actually care about position, so then you are likely happy to go back to
>"/dev/hdc" or "/dev/usb-cdrom" or something like that to specify _which_
>CD-RW you're talking about.
>


