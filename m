Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWERFOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWERFOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWERFOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:14:55 -0400
Received: from mx.pathscale.com ([64.160.42.68]:25760 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751175AbWERFOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:14:54 -0400
Subject: Re: [openib-general] Re: [PATCH 35 of 53] ipath - some
	interrelated stability and cleanliness fixes
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Dave Olson <olson@unixfolk.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <adaac9g3pae.fsf@cisco.com>
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
	 <fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no>
	 <Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
	 <ada4pzo5xti.fsf@cisco.com>
	 <Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com>
	 <adaac9g3pae.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 22:15:11 -0700
Message-Id: <1147929311.3094.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 21:55 -0700, Roland Dreier wrote:

> So with the "goto bail" you skip the code which does something with
> the work you allocate, which means that you leak not only the work
> structure but also the reference to the task's mm that you took.

Wow.  I have no idea where that extra "goto bail" came from.  It's not
supposed to be there.

	<b

