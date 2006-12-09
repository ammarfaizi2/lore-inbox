Return-Path: <linux-kernel-owner+w=401wt.eu-S933840AbWLIKQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbWLIKQO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 05:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936774AbWLIKQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 05:16:14 -0500
Received: from customer-domains.icp-qv1-irony12.iinet.net.au ([203.59.1.157]:35155
	"EHLO customer-domains.icp-qv1-irony12.iinet.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936595AbWLIKQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 05:16:13 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAOobekXKoQMBdGdsb2JhbAANjTEB
X-IronPort-AV: i="4.09,517,1157299200"; 
   d="scan'208"; a="76187297:sNHT30696759"
Message-ID: <457A8CEB.4080904@iinet.net.au>
Date: Sat, 09 Dec 2006 21:16:11 +1100
From: Ben Nizette <ben.nizette@iinet.net.au>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Matthias Schniedermeyer <ms@citd.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       DervishD <lkml@dervishd.net>
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no> <200612081201.36789.oliver@neukum.org> <457A5384.9070806@iinet.net.au> <200612090918.26508.oliver@neukum.org>
In-Reply-To: <200612090918.26508.oliver@neukum.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Samstag, 9. Dezember 2006 07:11 schrieb Ben Nizette:
>>>>> Also, you mentioned that the corruption occurs systematically on certain
>>>>> byte patterns. Therefore it's certainly not related to the cables.
>>>> It'd guess that too, but who can that say for sure. :-|
>>> You may have a bit pattern that stresses the controllers and suddenly
>>> a marginal cable may matter.
>> The errors occur in strings of 0xFFs.  From the USB standard:
>>
>> a “1” is represented by no change in level and a “0” is represented by a 
>> change in level
> 
> Yes, plus added stuffing bits.
> 
>> so this error-infested bytes are effectively long, quiet times on the 
>> wire.  I would have thought this would be the _least_ stressful time for 
>> the controllers but maybe they are also more susceptible to noise during 
>> this period.
> 
> The longer you don't change the voltage the likelier are reciever and
> transmitter to get out of sync.

Yes, hence the bit-stuffing, you're right :).  And hence this period 
isn't really too stressful for the controller as the stuffed bits come 
relatively often.

We're hoping that any wire-errors get picked up by the CRC anyway so a 
marginal cable under any circumstances shouldn't silently corrupt data. 
  I love that word 'shouldn't' ;)

Regards,
	Ben.
