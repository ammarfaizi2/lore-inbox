Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVHIHRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVHIHRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVHIHRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:17:21 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:45642 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932453AbVHIHRU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:17:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nTUiKOUA9S4fNAFo7jgTi1WycM9RBW7L675XZy5fiQdHcCGlRtLL5iFnp9uXpiC+1+CgCkcgrHaldJDfFaLqFDCe5avwOb6HTLUHHDTd5Yr6EvwXlohFpUGC898tw1ntDV1V2+Ws+FWvliJ6MLjXFa7bsj6zyVayVNVLxUwH2Yo=
Message-ID: <84144f0205080900175d95a91a@mail.gmail.com>
Date: Tue, 9 Aug 2005 10:17:11 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Cc: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>,
       mark.gross@intel.com
In-Reply-To: <200508080835.12431.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
	 <200507061414.48764.mgross@linux.intel.com>
	 <200508080835.12431.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/05, Mark Gross <mgross@linux.intel.com> wrote:
> Please tell me what you think :)

The formatting seems completely messed up presumably because of your
email client.

On 8/8/05, Mark Gross <mgross@linux.intel.com> wrote:
> + alarm_events = kcalloc(sizeof(struct tlclk_alarms), 1, GFP_KERNEL);

The first argument to kcalloc() is number of elements and the second
one is size of one element. In this case, however, use the new
kzalloc() which can be found in 2.6.13-rc5-mm1.

                                                   Pekka
