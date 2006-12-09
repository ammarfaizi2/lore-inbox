Return-Path: <linux-kernel-owner+w=401wt.eu-S1759175AbWLIGLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759175AbWLIGLT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759189AbWLIGLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:11:19 -0500
Received: from ihug-mail.icp-qv1-irony3.iinet.net.au ([203.59.1.197]:6256 "EHLO
	mail-ihug.icp-qv1-irony3.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759175AbWLIGLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:11:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAELieUXKoQMBdGdsb2JhbAANjTAB
X-IronPort-AV: i="4.09,517,1157299200"; 
   d="scan'208"; a="1061104161:sNHT17445760"
Message-ID: <457A5384.9070806@iinet.net.au>
Date: Sat, 09 Dec 2006 17:11:16 +1100
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
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no> <45793D82.1040807@s5r6.in-berlin.de> <457940DC.90403@citd.de> <200612081201.36789.oliver@neukum.org>
In-Reply-To: <200612081201.36789.oliver@neukum.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Also, you mentioned that the corruption occurs systematically on certain
>>> byte patterns. Therefore it's certainly not related to the cables.
>> It'd guess that too, but who can that say for sure. :-|
> 
> You may have a bit pattern that stresses the controllers and suddenly
> a marginal cable may matter.

The errors occur in strings of 0xFFs.  From the USB standard:

a “1” is represented by no change in level and a “0” is represented by a 
change in level

so this error-infested bytes are effectively long, quiet times on the 
wire.  I would have thought this would be the _least_ stressful time for 
the controllers but maybe they are also more susceptible to noise during 
this period.

Regards,
	Ben
