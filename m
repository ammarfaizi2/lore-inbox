Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWI1RKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWI1RKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWI1RKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:10:08 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:17470 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1751952AbWI1RKF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:10:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: forcedeth - WOL [SOLVED]
Date: Thu, 28 Sep 2006 10:09:24 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0189CAAA9@hqemmail02.nvidia.com>
In-Reply-To: <20060927203906.f4fc331e.akpm@osdl.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: forcedeth - WOL [SOLVED]
Thread-Index: Acbir7Rcsk0bxzlAT9+biq6uZzR5UwAcOBDw
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: "Andrew Morton" <akpm@osdl.org>,
       =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Cc: "Martin Filip" <bugtraq@smoula.net>, <linux-kernel@vger.kernel.org>,
       <stable@kernel.org>
X-OriginalArrivalTime: 28 Sep 2006 17:09:33.0289 (UTC) FILETIME=[DE319D90:01C6E320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Wednesday, September 27, 2006 8:39 PM
To: Björn Steinbrink
Cc: Martin Filip; linux-kernel@vger.kernel.org; Ayaz Abdulla; stable@kernel.org
Subject: Re: forcedeth - WOL [SOLVED]


On Thu, 28 Sep 2006 04:24:47 +0200
Björn Steinbrink <B.Steinbrink@gmx.de> wrote:

> On 2006.09.28 04:04:38 +0200, Björn Steinbrink wrote:
> > On 2006.09.27 18:36:25 -0700, Andrew Morton wrote:
> > > On Thu, 28 Sep 2006 03:01:33 +0200
> > > Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> > > 
> > > > > > > Do we know if this reversal *always* happens with this 
> > > > > > > driver, or only sometimes?
> > > > 
> > > > I only tried 2.6.18 twice this time, but when I wrote my own 
> > > > tool to do it, I had probably 20-30 power on -> ethtool -> 
> > > > poweroff cycles before I decided to look into Bugzilla. As it 
> > > > looked like being fixed already and I did use the nForce NIC for 
> > > > testing only, I didn't spend any further time on it back then.
> > > 
> > > What I'm angling towards is: "is this just a driver bug"?
> > 
> > I just took a peek at the code.
> > 
> > The version on bugzilla (last attachment, comment #22), which was 
> > reported to work correctly, has the MAC address reversal hardcoded. 
> > The driver in 2.6.18 has some logic to detect if it should reverse 
> > the MAC address. So it looks like a hardware oddity/bug that the 
> > driver wants to fix but fails. I'll see what happens if I force 
> > address reversal and if I can decipher anything, but probably 
> > someone else will have to cast the runes...
> 
> OK, please excuse me wasting your time, it's late over here... I've 
> actually been looking at Linus' git tree (pulled yesterday) while 
> writing that mail, not 2.6.18. 2.6.18 does _not_ contain the address 
> reversal detection. Using the git tree instead of 2.6.18 WOL works as 
> expected, without having to reverse the MAC address.
> 

hm, OK, thanks.  Ayaz, do you think 5070d3408405ae1941f259acac7a9882045c3be4 is a suitable thing for 2.6.18.x?

There are a few forcedeth patches (mac addr, NAPI, cleanup, etc) in that commit list and the mac address changes could be put into 2.6.18.x
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
