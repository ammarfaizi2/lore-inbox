Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTLHTEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTLHTEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:04:30 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:36362 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S261270AbTLHTE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:04:28 -0500
Message-ID: <3FD4CF90.3000905@nishanet.com>
Date: Mon, 08 Dec 2003 14:22:56 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: dialectical deprecation Re: cdrecord hangs my computer
References: <Law9-F31u8ohMschTC00001183f@hotmail.com><Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org><20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org><20031206220227.GA19016@work.bitmover.com> <Pine.LNX.4.58.0312061429080.2092@home.osdl.org><20031207110122.GB13844@zombie.inka.de> <Pine.LNX.4.58.0312070812080.2057@home.osdl.org> <1201390000.1070900656@[10.10.2.4]>
In-Reply-To: <1201390000.1070900656@[10.10.2.4]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>In contrast, the old cdrecord interfaces are an UNBELIEVABLE PILE OF CRAP!
>>It's an interface that is based on some random hardware layout mechanism
>>that isn't even TRUE any more, and hasn't been true for a long time. It's
>>not helpful to the user, and it doesn't match how devices are accessed by
>>everything else on the system.
>>
>>It's bad from a technical standpoint (anybody who names a generic device
>>with a flat namespace is just basically clueless), and it's bad from a
>>usability standpoint. It has _zero_ redeeming qualities.
>>    
>>
>
>I think the appropriate phrase is "user malevolent" software. Making
>the user interface fit some arcane technica rather than the user is
>rather tragic. Reality is quite complicated enough as it is, without
>deliberately setting out to make it more so.
>
>M.
>  
>
Today I realize that it's not double deprecation, it's dialectical
deprecation, for a user who gets caught between the deprecation
of ide-scsi and cdrecord targbuslun "flat" naming and then the
cdrecord error message when trying to use a full devpath. The
user's head is volleyed back and forth as cdrecord maintains
its "denial".

cdrecord whines about the full devpath in the first instance,
will not work if I use 1,0,0 in both places, but seems to
catch a clue about the devpath stub from the first instance
in order to use its 1,0,0 nomenclature below that.

#/etc/default/cdrecord
CDR_DEVICE=ATAPI:/dev/scsi/host1/bus0/target0/lun0/generic
#ATAPI:1,0,0 won't work in CDR_DEVICE, but...
yamaha=   ATAPI:1,0,0   -1      -1      ""

I'm scared(under-informed) to drop ide-scsi since
I'm using 3ware and don't know if just scsi-generic
would be enough for that hd controller(needs ide-scsi?
3ware's site doc is not easy to find).

-Bob

