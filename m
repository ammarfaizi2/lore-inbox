Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267192AbSK3Afr>; Fri, 29 Nov 2002 19:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267194AbSK3Afr>; Fri, 29 Nov 2002 19:35:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:223 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267192AbSK3Afq>;
	Fri, 29 Nov 2002 19:35:46 -0500
Date: Fri, 29 Nov 2002 16:44:35 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove IDESCSI_SG_TRANSFORM (compile fix)
Message-ID: <20021130004435.GB3182@beaverton.ibm.com>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	andre@linux-ide.org, linux-kernel@vger.kernel.org
References: <20021129235353.A13377@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129235353.A13377@lst.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig [hch@lst.de] wrote:
> In the current 2.5 scsi-misc tree Scsi_Device_Template.tag is gone.
> 
> ide-scsi is still using it in should_transform() to decide whether
> to test IDESCSI_SG_TRANSFORM or IDESCSI_TRANSFORM.
> 
> The obvious compile fix is to just kill that check, which makes
> IDESCSI_SG_TRANSFORM superflous.  Of course the question remains
> what the actual point of IDESCSI_SG_TRANSFORM was and if we still
> need it.

Thanks for catching this Christoph I thought the only use was inside
SCSI. I could make a patch to scsi-misc to add tag back in. Another
option if it is still needed is to switch to "->name == "generic").

Though I have not used this interface I thought if one was using an sg
device to a ide-scsi device and the flag was set that sg commands that
where not 100% the same as ATAP commands where translated.

-andmike
--
Michael Anderson
andmike@us.ibm.com

