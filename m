Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWABSKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWABSKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWABSKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:10:22 -0500
Received: from mx.pathscale.com ([64.160.42.68]:58530 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750936AbWABSKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:10:21 -0500
Subject: Correct Kbuild way to handle arches that don't implement
	readq/writeq?
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Mon, 02 Jan 2006 10:10:14 -0800
Message-Id: <1136225414.20330.25.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the requests during the first round of InfiniPath driver review
was to compile the driver on a 32-bit platform.  Our driver requires
64-bit MMIO operations (readq and writeq) that are not available on some
arches, such as i386, and which can't be emulated safely in terms of
32-bit operations.

What's the correct way to get the driver to not compile on such
platforms?  Do I use CONFIG_64BIT as a proxy for "has readq and writeq"?

	<b

