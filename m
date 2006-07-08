Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWGHNb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWGHNb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWGHNb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:31:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54247 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964824AbWGHNb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:31:56 -0400
Subject: Re: [RFC][PATCH 1/2] firmware version management: add
	firmware_version()
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Langer <martin-langer@gmx.de>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
In-Reply-To: <20060708130904.GA3819@tuba>
References: <20060708130904.GA3819@tuba>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 15:31:54 +0200
Message-Id: <1152365514.3120.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 15:09 +0200, Martin Langer wrote:
> It would be good if a driver knows which firmware version will be 
> written to the hardware. I'm talking about external firmware files 
> claimed by request_firmware(). 
> 
> We know so many different firmware files for bcm43xx and it becomes 
> more and more complicated without some firmware version management.
> 
> This patch can create the md5sum of a firmware file. Then it looks into 
> a table to figure out which version number is assigned to the hashcode.
> That table is placed in the driver code and an example for bcm43xx comes 
> in my next mail. Any comments?

Hi,

why does this have to happen on the kernel side? Isn't it a lot easier
and better to let the userspace side of things do this work, and even
have a userspace file with the md5->version mapping? Or are there some
practical considerations that make that hard to impossible?

(I personally don't care if the file comes with the kernel, that may be
the most convenient thing, but it would be a userspace file that the
userspace side of the firmware loader uses)

