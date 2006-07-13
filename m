Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWGMAzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWGMAzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWGMAzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:55:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751479AbWGMAzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:55:52 -0400
Date: Wed, 12 Jul 2006 17:55:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
Message-Id: <20060712175542.108e6e37.akpm@osdl.org>
In-Reply-To: <44B52674.8060802@suse.com>
References: <44B52674.8060802@suse.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 12:42:28 -0400
Jeff Mahoney <jeffm@suse.com> wrote:

>  On systems with block devices containing slashes (virtual dasd, cciss,
>  etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
>  it being interpreted as a subdirectory. The generic block device code
>  changes the / to ! for use in the sysfs tree. This patch uses that
>  convention.

Isn't it a bit dumb of us to be putting slashes in the device names anyway?
 It would be better, if poss, to alter dasd/cciss/etc and stop all these
s@/@!@everywhere games.
