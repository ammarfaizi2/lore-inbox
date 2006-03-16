Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWCPFLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWCPFLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 00:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWCPFLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 00:11:13 -0500
Received: from mail.dvmed.net ([216.237.124.58]:48789 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932400AbWCPFLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 00:11:13 -0500
Message-ID: <4418F36C.1090508@garzik.org>
Date: Thu, 16 Mar 2006 00:11:08 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Lin <ed.lin@promise.com>
CC: Matthew Wilcox <matthew@wil.cx>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "promise_linux@promise.com" <promise_linux@promise.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
References: <NONAMEBSkcJse1fTvOS000001bc@nonameb.ptu.promise.com>
In-Reply-To: <NONAMEBSkcJse1fTvOS000001bc@nonameb.ptu.promise.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Lin wrote:
> I think the tcq is good after reading the related kernel code. But driver
> still need to keep track of the tag for eh and flush. Maybe the driver
> can use find_first_zero_bit(), __set_bit(), and __test_and_clear_bit(),
> because this is what the block layer uses for tag operations.


Once mapped by the block layer, the tag should be accessible via struct
request::tag variable for the lifetime of the struct request.

	Jeff


