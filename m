Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVHQHcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVHQHcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 03:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVHQHcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 03:32:33 -0400
Received: from smtpout.mac.com ([17.250.248.47]:50911 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750922AbVHQHcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 03:32:32 -0400
In-Reply-To: <20050817053259.GA24060@lists.us.dell.com>
References: <4277B1B44843BA48B0173B5B0A0DED43528193@ausx3mps301.aus.amer.dell.com> <20050817053259.GA24060@lists.us.dell.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BB22B747-C7A7-443F-8DD7-BFD19A62F25D@mac.com>
Cc: Michael_E_Brown@Dell.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       Douglas_Warzecha@Dell.com, Chris Wedgwood <cw@f00f.org>,
       Nathan Lutchansky <lutchann@litech.org>, Valdis.Kletnieks@vt.edu,
       Andrey Panin <pazke@donpac.ru>, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@ucw.cz>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Wed, 17 Aug 2005 03:32:01 -0400
To: Matt Domsch <Matt_Domsch@Dell.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2005, at 01:33:00, Matt Domsch wrote:
> This is conceptually similar to how SCSI Generic (either
> /dev/sg or ioctl(SG_IO)) works (userspace passes in preformated SCSI
> CDBs and gets back the resultant CDBs and extended sense data).  The
> sg driver doesn't look at the data being passed down to any great
> extent.  It doesn't validate that the command will make sense to the
> end device.

This is not true anymore.  Recently the SG driver obtained a basic
form of SCSI command checking to prohibit vendor commands from those
processes without CAP_RAW_IO, even if said process had full access
to the device node itself.


Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



