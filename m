Return-Path: <linux-kernel-owner+w=401wt.eu-S1759126AbWLJWSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759126AbWLJWSy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbWLJWSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:18:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759006AbWLJWSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:18:54 -0500
Message-ID: <457C8791.9000201@redhat.com>
Date: Sun, 10 Dec 2006 17:17:53 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>,
       linux1394-devel@lists.sourceforge.net,
       Erik Mouw <erik@harddisk-recovery.com>,
       Marcel Holtmann <marcel@holtmann.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>	 <20061205160530.GB6043@harddisk-recovery.com>	 <20060712145650.GA4403@ucw.cz> <45798022.2090104@s5r6.in-berlin.de> <59ad55d30612091144s8356d7dw7c68530238ac79e7@mail.gmail.com> <457C042F.3040903@s5r6.in-berlin.de>
In-Reply-To: <457C042F.3040903@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Kristian Høgsberg wrote:
...
>> I'm not changing it just yet, but I'm not too attached to fw_
>> and I think that ieee1394_ will work better.  The modutil tools
>> already use ieee1394 for device_id tables.
> [...]
> 
> Alas the length of "ieee1394_" gets in the way of readability.

It's not too bad and it's only for exported symbols:

[krh@dinky fw]$ grep EXPORT *.c | wc -l
27

and using the same prefix as the device_id struct will be nice.  When I 
submitted the ieee1394_device_id patch I originally proposed hpsb_device_id, 
but nobody knew what that meant so we went with the ieee1394_device_id we have 
now.  Oh, and net/ieee80211 uses ieee80211 as prefix, so it wont be the 
longest subsytem prefix :).  Plus I want to go throught the list of exported 
symbols, some of the names can be trimmed a bit.

Having said that, using drivers/firewire and the fw_ prefix, as Marcel 
suggests, works too.  It's what bluetooth and infiniband does, so there is 
some precedence there.

...
> I would therefore prefer "fw_" or "hpsb_" over any of the other suggestions
> made here:
>   - ieee1394_ makes sense in linux/mod_devicetable.h but is too long
>     otherwise.
>   - fiwi_, frwr_, and fwire_ are artificial abbreviations which come very
>     unnatural. (fw_ is an artificial abbreviation too but is not as awkward
>     as the others. hpsb_ is not just an abbreviation, it is an established
>     acronym of the canonical name of the bus.)

Oh, I don't know... for the longest time I didn't know what hpsb meant, and 
high performance serial bus is pretty generic sounding... are we talking about 
usb, sata, ieee1394 or rs232?  Ok, I guess rs232 is neither hp or b.  But 
seriously, except for the current stack, I've never seen the hpsb abbreviation 
used much.

Kristian


