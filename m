Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVI2GbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVI2GbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVI2GbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:31:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5814 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932092AbVI2GbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:31:15 -0400
Date: Thu, 29 Sep 2005 07:31:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-sh@m17n.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] breakage either in arch/sh/Kconfig or arch/sh/kernel/process.c?
Message-ID: <20050929063114.GT7992@ftp.linux.org.uk>
References: <20050929061239.GS7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929061239.GS7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 07:12:39AM +0100, Al Viro wrote:
> set.  Now, in arch/sh/Kconfig we see that SH_FPU depends on !CPU_SH3 and SH_DSP
> on !CPU_SH4.  Which leaves CPU_SH2 picking both options.
> 
> Comments?  Looks like either Kconfig or flush_thread() needs fixing...

And that would be Kconfig, from the look of it.  Any suggestions on the
dependencies?
