Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWBNQZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWBNQZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWBNQZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:25:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37868 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161116AbWBNQZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:25:02 -0500
Date: Tue, 14 Feb 2006 16:24:58 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: jzb@aexorsyst.com, linux-kernel@vger.kernel.org
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
Message-ID: <20060214162458.GD27946@ftp.linux.org.uk>
References: <200602132316.15992.jzb@aexorsyst.com> <43F1FA74.80607@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F1FA74.80607@cfl.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:42:44AM -0500, Phillip Susi wrote:

> This is expected behavior.  The kernel doesn't have a /dev at the time 
> it mounts the root fs so it has no idea what /dev/sda1 is.

Incorrect.  Read init/do_mounts.c::name_to_dev_t().
