Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVJTSfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVJTSfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 14:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJTSfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 14:35:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35998 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750760AbVJTSfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 14:35:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4357E2D3.9090206@s5r6.in-berlin.de>
Date: Thu, 20 Oct 2005 20:32:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
CC: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@plato.virtuousgeek.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>, gregkh@suse.de
Subject: Re: new PCI quirk for Toshiba Satellite?
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de> <20051015202944.GA10463@plato.virtuousgeek.org> <20051015204040.GA10537@plato.virtuousgeek.org> <20051020000614.GI18295@kroah.com>
In-Reply-To: <20051020000614.GI18295@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.555) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Oct 15, 2005 at 01:40:40PM -0700, Jesse Barnes wrote:
>>>On Sat, Oct 15, 2005 at 09:39:06PM +0200, Stefan Richter wrote:
>>>>Somebody mentioned this Linux-on-Toshiba-Satellite page recently on 
>>>>linux1394-user: http://www.janerob.com/rob/ts5100/index.shtml
>>>>The patch available from there was briefly discussed in February:
>>>>http://marc.theaimsgroup.com/?l=linux1394-devel&t=110786507900006
...
>>It seems that the PCI config space isn't programmed correctly on these
>>machines for some reason, so the fix below allows my OHCI device to work
>>if I pass 'toshiba=1'.  This seems like something that belongs in the
>>PCI layer instead though, doesn't it?
> 
> Yes, looks like it should be a pci quirk instead.

I gather from DMI info provided by Rob and Jesse that affected machines 
could be determined by dmi_check_system() using these two checks:
   - DMI_SYS_VENDOR contains "TOSHIBA" && DMI_PRODUCT_VERSION contains
     "PS5", i.e. most of Satellite 5xxx, as well as
   - DMI_SYS_VENDOR contains "TOSHIBA" && DMI_PRODUCT_VERSION contains
     "PSM4", i.e. all Satellite M4x.
A few more series are probably affected too.

http://marc.theaimsgroup.com/?l=linux-kernel&m=112955338318326
http://marc.theaimsgroup.com/?l=linux-kernel&m=112974457930368
http://linux.toshiba-dme.co.jp/linux/eng/speclist.php3

BTW, the author of the initial incarnation of the patch is this person:
http://nemaru.at.infoseek.co.jp/1394.html
-- 
Stefan Richter
-=====-=-=-= =-=- =-=--
http://arcgraph.de/sr/
