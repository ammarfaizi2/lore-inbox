Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWEZKIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWEZKIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWEZKIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:08:35 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:6293 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751359AbWEZKIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:08:34 -0400
Date: Fri, 26 May 2006 12:08:30 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3ware 7500 not working in 2.6.16.18, 2.6.17-rc5
Message-ID: <20060526100830.GU20917@fi.muni.cz>
References: <6gn8D-4AV-13@gated-at.bofh.it> <447661E2.5020103@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447661E2.5020103@shaw.ca>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
: It looks like this controller only supports 32-bit DMA addresses. For 
: some reason it's trying to feed in an SG list with addresses over 4GB, 
: which fails. I'd think this configuration should work, but maybe not?

	It worked in 2.6.15-rc2.

: It looks like you have IOMMU turned off - I think you'll really want to 
: turn that on with that much RAM (12GB). Even if this case did work as 
: well as it could, without IOMMU the kernel would have to bounce-buffer 
: the data below 4GB which will kill performance.

	Yes, I had problems with IOMMU in the past, so I used to run the
kernel with IOMMU turned off. Now I have turned it back on, and so far
it is working correctly. However, I think the 3ware driver should work even
with iommu=off (as it used to in 2.6.15-rc2).

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
