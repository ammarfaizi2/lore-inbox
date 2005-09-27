Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVI0VpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVI0VpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVI0VpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:45:11 -0400
Received: from magic.adaptec.com ([216.52.22.17]:22202 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965163AbVI0VpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:45:08 -0400
Message-ID: <4339BD58.7060300@adaptec.com>
Date: Tue, 27 Sep 2005 17:44:56 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <4339440C.6090107@adaptec.com>	 <20050927131959.GA30329@infradead.org>  <43395ED0.6070504@adaptec.com> <1127836380.4814.36.camel@mulgrave> <43399F17.4090004@adaptec.com> <4339ACDA.3090801@pobox.com>
In-Reply-To: <4339ACDA.3090801@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 21:45:05.0841 (UTC) FILETIME=[B92C5A10:01C5C3AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/05 16:34, Jeff Garzik wrote:
> Luben,
> 
> The fact that your responses are constantly filled with non-technical 
> paranoia does not help the inclusion of aic94xx at all.
> 
> Maybe you need to write your driver as a block driver, and completely 
> skip the SCSI core, if it bothers you so much?  That would get everybody 
> else out of the loop, and free you to write the driver as you see fit.

Hi Jeff, how are you doing?

Yes, that has been suggested before.  But do you remember what
happened when I posted a patch to IDR?  James moved from SCSI Core
to IDR. hehehe ;-)

In the mids of the FUD, I completely removed IDR from being used
in aic94xx, long before I posted the driver.

> As it stands now, you're making an end run around the SCSI core, rather 
> than fixing it up.  SCSI needs to be modified for SAS, not just 
> complained about.

Well, back in 2001-2 I was asking for 64 bit LUN support and
for native SCSI target support (since iSCSI "exports" targets), and
it uses 64 bit LUNs (as any other transport).  Both sniffed at
and rejected by your friends.

See this thread from me, all the way back in 2002:
http://marc.theaimsgroup.com/?l=linux-scsi&m=103013448713434&w=2

You still have people from IBM who claim that 64 bit LUN
support is completely unnecessary as recently as 2 weeks ago.
(link to email on marc.10east.com available upon request)

As it has come to now, 2005, we cannot afford any more "putting off".

The driver and the infrastructure needs to go in.

Give it exposure to the people, let people play with it.

If we start "fixing" SCSI Core now (this in itself is JB red
herring), how long before it is "fixed" and we can "rest"?
And how long then before the driver and infrastructure
makes it in?

"How long is the long hair?"

You are calling for fixing SCSI Core.  JB is calling for
integrating MPT with open transport.  I'm sure people
have other (crazy) requests.

At the end of the day the driver is not in, and business
suffers.  And its not like the driver is using 
static struct file_operations megasas_mgmt_fops, ;-)
IOCTLs or other char dev for management...

The driver does _not_ alter anything in the kernel, it only
integrates with it.

There needs to be a "passing gate":
Linus, let the driver and transport layer in, as is and then
patches "fixing SCSI Core" would start coming, naturally.
>From people, from me, from everybody.

	Luben

