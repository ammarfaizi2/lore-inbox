Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUDAAK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUDAAKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:10:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6866 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262143AbUDAAKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:10:47 -0500
Message-ID: <406B5DFA.80201@pobox.com>
Date: Wed, 31 Mar 2004 19:10:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Boutcher <sleddog@us.ibm.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ibmvscsi driver - sixth version
References: <opr3u0ffo7l6e53g@us.ibm.com> <20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com> <1079027038.2820.57.camel@mulgrave> <opr5qwiyw4l6e53g@us.ibm.com> <406B3FDA.9010507@pobox.com>  <opr5q1enb6l6e53g@us.ibm.com> <1080776399.11299.63.camel@mulgrave> <opr5q28vkql6e53g@us.ibm.com>
In-Reply-To: <opr5q28vkql6e53g@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Boutcher wrote:
> There will always be 1 (no more, no less) of these struct devices in the
> system, so I'll move the definition of this into iSeries_iommu and then
> just reference it from the driver.  I think that should abstract things
> sufficiently.


Sounds like a small module declaring devices such as this would be more 
appropriate than unrelated iommu code?

In a regular PCI system, the PCI bus probing code creates devices.  For 
platform-specific virtual devices, ppc64 needs "create my virtual 
devices" initialization code, it looks like.

	Jeff



