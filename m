Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbUKRQvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbUKRQvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUKRQvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:51:19 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:45577 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S262535AbUKRQtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:49:32 -0500
Message-ID: <419CEC65.4020603@gentoo.org>
Date: Thu, 18 Nov 2004 18:39:33 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Missing SCSI command in the allowed list?
References: <cmikie$vif$1@sea.gmane.org> <200411061624.57918.dsd@gentoo.org> <cmkkd8$dm8$1@sea.gmane.org>
In-Reply-To: <cmkkd8$dm8$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.9 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CUpTI-0003y9-Cl*ZD5b5mxGoHk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alexander E. Patrakov wrote:
> But the question remains: what should the users of not 100% MMC-compatible
> CR-RW drives (i.e. those which have a separate cdrado or cdrecord driver,
> not generic-mmc/generic-mmc-raw) do? Is the support for writing as non-root
> on such drives just dropped without any plans to "fix" it?

I'd also be interested to know the answer here. Jens?

Some Gentoo users have reported that commands such as ED/EB/E9/F5 are being 
rejected. When inspecting the cdrecord source code, it seems that these are 
specific to plextor drives. These drives are MMC but have a few 
vendor-specific extensions. How should we go about permitting cases like this 
in the command filter?

Thanks,
Daniel
