Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVLNUMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVLNUMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVLNUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:12:14 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:41170 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964928AbVLNUMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:12:13 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43A07C05.90800@s5r6.in-berlin.de>
Date: Wed, 14 Dec 2005 21:09:41 +0100
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
References: <20051209171922.GW19441@conscoop.ottawa.on.ca> <200512101125.jBABP7Z9001085@einhorn.in-berlin.de> <20051210232837.GE11094@kroah.com> <439B7A8F.6000209@s5r6.in-berlin.de>
In-Reply-To: <439B7A8F.6000209@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.471) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote on 2005-12-11:
> Greg KH wrote:
>> On Sat, Dec 10, 2005 at 12:24:59PM +0100, Stefan Richter wrote:
>>> Sbp2 did not catch some bogus transfer directions in requests from upper
>>> layers.
...
>> Is this in linus's tree yet? 
...
>> Do the 1394 maintainers accept it as a valid fix?
...
> Jody posted a NAK a few hours ago:
> || NAK.  James has a patch to fix this in the SCSI layer, which is his
> || preference.

FYI, James' fix for sd_init_command etc. is this one:
http://www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;a=commit;h=c9526497cf03ee775c3a6f8ba62335735f98de7a

It depends on the following patch to apply cleanly (but does not 
actually require it to work and fix the iPod related panic):
http://www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;a=commit;h=a8c730e85e80734412f4f73ab28496a0e8b04a7b

Sorry for any confusion I might have created,
-- 
Stefan Richter
-=====-=-=-= ==-- -===-
http://arcgraph.de/sr/
