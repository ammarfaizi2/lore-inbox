Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWCWIhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWCWIhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWCWIhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:37:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:11916 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030216AbWCWIhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:37:08 -0500
Subject: Re: [PATCH 10 of 18] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
In-Reply-To: <20060322190636.667d43c0.akpm@osdl.org>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <35c1d2f22ae1e2de483c.1143072303@eng-12.pathscale.com>
	 <20060322190636.667d43c0.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 00:37:07 -0800
Message-Id: <1143103027.6411.9.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 19:06 -0800, Andrew Morton wrote:

> CPU topology is available in sysfs - it shouild be possible to push policy
> decisions like this up to userspace.

We covered this in an earlier round of submission, but I should have
updated the inline comments.

While we expose a way for userspace to open an explicit device based on
its knowledge of topology, I think we need a "take your best shot" minor
number, too, which is what this is.

If we *don't* provide one, userspace can end up with exactly the kinds
of messy race situations that used to be seen with ptys before /dev/ptmx
and /dev/pts came along.

	<b

