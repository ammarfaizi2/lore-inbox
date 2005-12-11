Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbVLKBER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbVLKBER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 20:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbVLKBER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 20:04:17 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:21149 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161083AbVLKBEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 20:04:16 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <439B7A8F.6000209@s5r6.in-berlin.de>
Date: Sun, 11 Dec 2005 02:02:07 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: stable@kernel.org, torvalds@osdl.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       adq@lidskialf.net, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [stable] [PATCH] sbp2: fix panic when ejecting an ipod
References: <20051209171922.GW19441@conscoop.ottawa.on.ca> <200512101125.jBABP7Z9001085@einhorn.in-berlin.de> <20051210232837.GE11094@kroah.com>
In-Reply-To: <20051210232837.GE11094@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.412) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Dec 10, 2005 at 12:24:59PM +0100, Stefan Richter wrote:
> 
>>sbp2: fix panic when ejecting an ipod
>>
>>Sbp2 did not catch some bogus transfer directions in requests from upper
>>layers.  Problem became apparent when iPods were to be ejected:
>>http://marc.theaimsgroup.com/?l=linux1394-devel&m=113399994920181
>>http://marc.theaimsgroup.com/?l=linux1394-user&m=112152701817435
>>Debugging and original variant of the patch by Andrew de Quincey.
>>
>>Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
>>Cc: Andrew de Quincey <adq@lidskialf.net>
> 
> 
> Is this in linus's tree yet? 

My idea was that it goes in parallel to Linus and to -stable, hence the 
selection of recipients of my posting.

I will submit two related cleanup patches for sbp2 to linux1394-devel on 
Sunday morning. They will remove obsolete code and reformat code for 
readability. IMO they will *not* be suitable for Linus' tree before the 
next subsystem merge window.

> Do the 1394 maintainers accept it as a valid fix?

Ben Collins and I are *sbp2* maintainers. I consider it a valid fix (but 
see below.) Jody McIntyre and Ben are *1394* maintainers. Jody posted a 
NAK a few hours ago:
|| NAK.  James has a patch to fix this in the SCSI layer, which is his
|| preference.

I agree with Jody and the SCSI people that Jens' and James' patches are 
the actual fixes. What I want to accomplish is twofold:
  - Don't let tiny mistakes lead to catastrophic failure (panic) if it
    can be avoided without additional code.
  - Get the panic fixed in -stable in one way or another ASAP.

James, I assume Jens' and your patch will be in Linus' tree soon. 
Therefore and because my pending sbp2 cleanups will land in Linus' tree 
eventually, this sbp2 patch here is not vital for the current kernel. 
But do you consider to submit the SCSI fixes or a derivative to -stable 
too? If not, I recommend my patch to be included in -stable.

Jody, I very much respect and appreciate your opinion. Please continue 
to step in the way when I'm doing goofy things. :-)
-- 
Stefan Richter
-=====-=-=-= ==-- -=-==
http://arcgraph.de/sr/
