Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVHPUlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVHPUlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVHPUlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:41:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7888 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932438AbVHPUly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:41:54 -0400
Date: Tue, 16 Aug 2005 13:41:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 3/6] i386 virtualization - Make ldt a desc struct
Message-ID: <20050816204149.GN7991@shell0.pdx.osdl.net>
References: <200508161306_MC3-1-A75D-6646@compuserve.com> <430233FF.7090106@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430233FF.7090106@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Several reviewers noticed that initialization and destruction of the
> mm->context is unnecessary, since the entire MM struct is zeroed on
> allocation anyways.

well, on fork it should be just shallow copied rather than zeroed.
