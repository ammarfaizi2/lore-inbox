Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWBMQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWBMQVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWBMQVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:21:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:28563 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750833AbWBMQVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:21:05 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43F0B1AB.6010708@s5r6.in-berlin.de>
Date: Mon, 13 Feb 2006 17:19:55 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jody McIntyre <scjody@modernduck.com>
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de> <20060208230559.GK27946@ftp.linux.org.uk>
In-Reply-To: <20060208230559.GK27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.541) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote on 2006-02-09:
> On Wed, Feb 08, 2006 at 11:35:18PM +0100, Stefan Richter wrote:
...
>>not a single one of these bridges is affected by the code 
>>change since the additional expression which was added always evaluates 
>>true.
> 
> The hell it does.  Try scsiinfo -s and you'll see.  All INQUIRY generated
> by scsi midlayer have both flags set to 0.  Userland ones do not;
...

OK, tested scsiinfo now with 9 bridges (8 or 7 different chips).
The patch obviously works as expected.

Jody, are you going to channel the patch through your tree?

BTW, a Prolific based enclosure indeed seems to be unable to handle
CD-ROMs after scsiinfo treatment. An enclosure based on an old
revision of TI StorageLynx apparently causes mode_sense -> check
condition/ unit attention loops when scsiinfo tries to access some
mode page.
-- 
Stefan Richter
-=====-=-==- --=- -==-=
http://arcgraph.de/sr/
