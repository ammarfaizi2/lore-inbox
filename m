Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWG3IS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWG3IS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 04:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWG3IS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 04:18:26 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:21681 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1751089AbWG3ISZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 04:18:25 -0400
X-OB-Received: from unknown (205.158.62.51)
  by wfilter2.us4.outblaze.com; 30 Jul 2006 08:18:25 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Simon White" <s_a_white@email.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 30 Jul 2006 03:18:24 -0500
Subject: Re: Driver model ISA bus
X-Originating-Ip: 82.9.64.190
X-Originating-Server: ws1-5.us4.outblaze.com
Message-Id: <20060730081824.2763A478088@ws1-5.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jun 06, 2006 at 11:54:02PM +0200, Rene Herman wrote:
>> Hi Greg.
>> 
>> The below was sent a month ago and I haven't heard anything back. Saw 
>> you saying "it's getting there" about this thing on the kernelnewbies 
>> list but where's there?
>> 
> 
> Sorry for the delay.  It looks great to me so I've added it to my tree
> and will push it upstream when I can.

Would it be better to have a name variable directly in isa_device and
then copy that to driver in isa_register_device (like
pci_register_device does)?

I was trying to look for use examples of this code in 2.6.18-rc2 but
didn't see any.  Is the intent of name to be the cards address, and
ndev to be the function on a specific card?  Would it be better to
seperate name from the thing that ends up in bus_id?

I only ask as was looking to use something similiar to other code
I've seen in kernel in that it seemed the bus_type + bus_id would
uniquely identify a particular card that would pretty much persist
(on removal/addition of hardware?).  When a legacy isa device was
found by this code they switched to mangling an id from the cards
address.

I think between that and a probe test you could make pretty sure
you had exactly the same card.  Am wondering if this code allowed
for something similiar, in that bus_type + bus_id could be stored
and used later to locate the same card.

Regards,
Simon


-- 
___________________________________________________
Play 100s of games for FREE! http://games.mail.com/

