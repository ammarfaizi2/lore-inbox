Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWIUSLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWIUSLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWIUSLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:11:31 -0400
Received: from hierophant.serpentine.com ([64.81.58.173]:3033 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1751433AbWIUSLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:11:30 -0400
Subject: Re: Flushing writes to PCI devices
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Bill Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
References: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no>
	 <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org>
	 <fa.V4O8HKrhUddxYm5+ixVbyZzPybE@ifi.uio.no>
	 <6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 11:14:02 -0700
Message-Id: <1158862442.29551.22.camel@sardonyx>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 12:41 -0700, Bill Waddington wrote:

> Are there ever any issues with out-of-order writes from the posting
> buffer on supported architectures?

Yes.  If your device requires that writes to some locations in MMIO
space be performed in a specific order, you must explicitly do this in
your driver.  Intel CPUs will flush posted writes out of order, for
example.

	<b

