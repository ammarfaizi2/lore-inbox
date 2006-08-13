Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWHMWFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWHMWFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 18:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWHMWFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 18:05:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751675AbWHMWFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 18:05:04 -0400
Date: Sun, 13 Aug 2006 15:04:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 5/5] swsusp: Use memory bitmaps during resume
Message-Id: <20060813150457.43ba5893.akpm@osdl.org>
In-Reply-To: <200608101523.41107.rjw@sisk.pl>
References: <200608101510.40544.rjw@sisk.pl>
	<200608101523.41107.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 15:23:41 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Make swsusp use memory bitmaps to store its internal information during the
> resume phase of the suspend-resume cycle.

This patch makes the resume-time disk IO go all slow again.

Time to read 80k pages:

2.6.18-rc4:				24 seconds
2.6.18-rc4+akpm-speedups:		10 seconds
2.6.18-rc4+akpm-speedups+this-patch:	24 seconds

