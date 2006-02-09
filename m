Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWBIJMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWBIJMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbWBIJMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:12:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030219AbWBIJMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:12:22 -0500
Date: Thu, 9 Feb 2006 01:11:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: 76306.1226@compuserve.com, pj@sgi.com, heiko.carstens@de.ibm.com,
       wli@holomorphy.com, ak@muc.de, mingo@elte.hu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060209011106.68aa890a.akpm@osdl.org>
In-Reply-To: <20060209010655.5cdeb192.akpm@osdl.org>
References: <200602090335_MC3-1-B7FA-621E@compuserve.com>
	<20060209010655.5cdeb192.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> aargh.
>

Actually, x86 appears to be the only arch which suffers this braindamage. 
The rest use CPU_MASK_NONE (or just forget to initialise it and hope that
CPU_MASK_NONE equals all-zeroes).

