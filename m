Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVLAUtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVLAUtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbVLAUtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:49:24 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:17942 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S1751724AbVLAUtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:49:23 -0500
Date: Thu, 1 Dec 2005 14:49:22 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Terence Ripperda <tripperda@nvidia.com>,
       Dave Airlie <airlied@gmail.com>
Subject: Re: PAT status?
Message-ID: <20051201204922.GT4365@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <438CD4AD.9070806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438CD4AD.9070806@pobox.com>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.13 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 01 Dec 2005 20:49:23.0150 (UTC) FILETIME=[B59FEEE0:01C5F6B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I unfortunately haven't had much time to look at the status of the PAT
code I had been working on. there are really 2 steps to the code:

the first is enabling and configuring the PAT registers. this then
allows a page table entry define that can be passed to traditional
interfaces, such as remap_page_range or change_page_attr. this is
pretty simple and we've been using a similar interface in our driver
for some time now.

the second part was to make sure we didn't create any cache aliasing
via duplicate mappings. this part is a bit more involved and what was
holding everything back. I've been meaning to get back to looking at
this, but really haven't had the time.

I don't know if you still want to limit the additional of the first
step, based on completion of the second step. I can try to set time
aside over the next month to try and sync up and take a look at where
we stand w/ the cachemap portion of the code. I think there where
still issues with gathering/passing in the correct attributes.

Thanks,
Terence


On Tue, Nov 29, 2005 at 05:22:37PM -0500, jgarzik@pobox.com wrote:
> 
> What's the status of PAT support?
> 
> I'm interested in that sort of stuff, for use with on-board GPUs such as 
> Intel/VIA/SiS, where system memory is used rather than offboard ram.
> 
> 	Jeff
> 
> 
> 
