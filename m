Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTDXBRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 21:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTDXBRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 21:17:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:64410 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264370AbTDXBRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 21:17:13 -0400
Date: Wed, 23 Apr 2003 18:18:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jamie Lokier <jamie@shareable.org>,
       Werner Almesberger <wa@almesberger.net>
cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <1613630000.1051147126@flay>
In-Reply-To: <20030424011137.GA27195@mail.jlokier.co.uk>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't quite see how this would make user space any less
>> fancy:
>> 
>> # insmod audio_driver volume=`retrieve_volume`
>> 
>> versus
>> 
>> # insmod audio_driver
>> # aumix -L >/dev/null
> 
> Eh?  I was suggesting that the _default_ just work as quite a few
> people expect:
> 
> 	$ insmod audio_driver
> 
> In fact, forget about "volume".  Just have a "silent" parameter that
> defaults to 0, and determines whether the device starts silent or
> loads preset defaults.  Make it a core audio thing rather than a
> per-driver thing, too.  "silent=1" in /etc/modules.conf self-evidently
> answers the FAQ, too :)

Me like. Assuming this means what I think it does ;-)

The kernel sets a default quiet volume level (at first setup) to make some 
sort of  noise when used I first set up the machine so users don't get 
confused ... save & restore volume levels on every boot from userspace. 
If people want silent by default, they can change that in the 
modules.conf / command line.

Is that what you meant?

M.

