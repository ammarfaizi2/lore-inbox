Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTIKQzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbTIKQzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:55:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44433 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261397AbTIKQzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:55:21 -0400
Date: Thu, 11 Sep 2003 17:55:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: richard.brunner@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911165515.GD29532@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B197@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B197@txexmtae.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner@amd.com wrote:
> Don't worry! I am pretty certain the patch won't impact the 
> performance of the 2.6 kernel on processors from other vendors ;-)

is_prefetch() will slow down programs which depend on lots of SEGV
signals: those garbage collectors which use mprotect and SIGSEGV to
track dirty pages.

I wonder how much it will slow them down.

-- Jamie
