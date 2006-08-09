Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWHIQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWHIQHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWHIQHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:07:40 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:9918 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751090AbWHIQHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:07:39 -0400
Date: Wed, 09 Aug 2006 12:07:26 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward
 compatibilty?
In-reply-to: <20060809184658.2bdfb169@comp.home.net>
To: linux-kernel@vger.kernel.org
Cc: Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net
Message-id: <200608091207.26156.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200608091140.02777.gene.heskett@verizon.net>
 <20060809184658.2bdfb169@comp.home.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 11:46, Sergei Steshenko wrote:
>On Wed, 09 Aug 2006 11:40:02 -0400
>
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> Greetings;
>>
>> The old fart is back again. :)
>>
>> I've just done a divide and conquer on kernel versions, and have found
>> that while I DO have a kde audio signon for kernels 2.6.18-rc1-rc3-rc4,
>> I do not have any other functioning audio, including the kde sound
>> effects I normally get.  xmms and tvtime are mute, as are the firefox
>> plugins to play videos from the network. 2.6.17.8 and below works great
>> yet.
>>
>> So whats the fix?
>
>Demand stable ABI.

It does not appear to be so.  And ATM booted to 18-rc1, I didn't see an 
error message when rc.local made a call of "[root@coyote gene]# alsactl 
restore
alsactl: set_control:894: warning: name mismatch (Mic Boost (+20dB)/Mic 
Boost (+20dB) Switch) for control #45
alsactl: set_control:896: warning: index mismatch (0/0) for control #45
alsactl: set_control:898: failed to obtain info for control #45 (Operation 
not permitted)
[root@coyote gene]#

But as you can see, the error was there nontheless.  I've seen this or a 
very similar error for .18-rc3 and .18-rc4.

This walks and qwacks like the alsa interface has been diddled, again.  But 
since it KNOWS what hardware its running, in this case an audigy 2, not 
Value, so why was apparently working code broken and then commited to the 
kernel tree?

Humm, because of my use of 2 independant audio channels here, I'm forced to 
use kamix in order to address both systems.  And I found it!  Somehow, 
that card managed to get its "external amplifier" 'led' turned on, which 
apparently kills the normal line outs that drive my speakers.  The display 
also looks slightly busier, like another slider has been added?

Now to check the newer kernels again after doing an 'alsactl store' from 
the cli.  Once I've done that, the above error is not repeated.

And, even kookier, is that after doing the alsactl store, the external 
amplifier button no longer effects it.  Anybody got any migrain medicine?

And tvtime now has a voice too, goodie.. :)

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
