Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVK1E6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVK1E6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 23:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVK1E6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 23:58:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751231AbVK1E6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 23:58:16 -0500
Date: Sun, 27 Nov 2005 20:57:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: greg@kroah.com, kaos@sgi.com, ak@suse.de, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-Id: <20051127205745.78b565ec.akpm@osdl.org>
In-Reply-To: <20051128024301.GA8651@us.ibm.com>
References: <20051127172725.GJ20775@brahms.suse.de>
	<24158.1133113176@ocs3.ocs.com.au>
	<20051127115640.3073f8e3.akpm@osdl.org>
	<20051127220329.GA17786@kroah.com>
	<20051128024301.GA8651@us.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> Any options I missed?

Stop using the notifier chains from NMI context - it's too hard.  Use a
fixed-size array in the NMI code instead.

