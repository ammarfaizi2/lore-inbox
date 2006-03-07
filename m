Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWCGPrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWCGPrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCGPrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:47:37 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53940 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751237AbWCGPrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:47:36 -0500
X-Sasl-enc: rbkIGC+YD7MQDbHN95pUH025w8xrMSpow15TRsm/PQLX 1141746434
Date: Tue, 7 Mar 2006 12:47:10 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: Dave Peterson <dsp@llnl.gov>, Andrew Morton <akpm@osdl.org>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net, thayne@realmsys.com
Subject: Re: [PATCH 7/15] EDAC: i82875p cleanup
Message-ID: <20060307154710.GA23763@khazad-dum.debian.net>
References: <200603031047.01445.dsp@llnl.gov> <20060307050609.GA32733@zhen-devel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307050609.GA32733@zhen-devel.sh.intel.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006, Wang Zhenyu wrote:
> On 2006.03.04 02:47:01 +0000, Dave Peterson wrote:
> >    On Thursday 02 March 2006 18:30, Andrew Morton wrote:
> >    > Dave Peterson <dsp@llnl.gov> wrote:
> >    > >  +#ifdef CORRECT_BIOS
> >    > >  +fail0:
> >    > >  +#endif
> >    >
> >    > What is CORRECT_BIOS?  Is the fact that it's never defined some sort of
> >    > commentary?  ;)
> >    I'm not sure about this.  I'm cc'ing Thayne Harbaugh and Wang Zhenyu since
> >    their names are in the credits for the i82875p module.  Maybe they can
> >    provide some info.
> 
> You can take CORRECT_BIOS as "strict-pci-resource-reserve" for overflow device
> in 82875p, some bad BIOS does make it reserved, which cause pci_request_region()
> failed.  Actually we never defined it. 

Bad? :-)  It would be bad only if they didn't *hide* the overflow device.
Regardless of the overflow device being hidden or not, that area is really
in use, and should be known to be in use.  How can you know it is in use if
the device is hidden, unless the BIOS reserves it?

Let's call that "inconvenient" BIOSes instead...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
