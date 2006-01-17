Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWAQXvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWAQXvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWAQXvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:51:41 -0500
Received: from fmr17.intel.com ([134.134.136.16]:23438 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932516AbWAQXvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:51:39 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Stephen Hemminger'" <shemminger@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <openib-general@openib.org>
Subject: RE: [PATCH 2/5] [RFC] Infiniband: connection abstraction
Date: Tue, 17 Jan 2006 15:51:23 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcYbv4GKi3GOH7PgQ7SAUxpZSCxGzgAAKDgg
In-Reply-To: <20060117153838.3dc2cd2e@dxpl.pdx.osdl.net>
Message-ID: <ORSMSX401eBBsQwY6YH00000044@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 17 Jan 2006 23:51:23.0544 (UTC) FILETIME=[EC1A1180:01C61BC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static void cm_mask_compare_data(u8 *dst, u8 *src, u8 *mask)
>
>static void cm_mask_compare_data(u8 *dst, const u8 *src, u8 *mask)
>
>but I would rename it to cm_mask_copy since it doesn't really do a compare.

I'll change this.  The function is masking the "data to use in the comparison",
but I can see the confusion.

>> +static int cm_compare_data(struct ib_cm_private_data_compare *src_data,
>> +			   struct ib_cm_private_data_compare *dst_data)
>
>static int cm_compare_data(const struct ib_cm_private_data_compare *src,
>		           cosnt struct ib_cm_private_data_compare *dst)
>Your data type names are getting too long ^^^^^^^^^^^^^^^^^^^^^^^^

I'll fix.

Thanks for the comments.

- Sean

