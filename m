Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWERILU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWERILU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWERILU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:11:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751283AbWERILU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:11:20 -0400
Date: Thu, 18 May 2006 01:11:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tim Mann <mann@vmware.com>
Cc: linux-kernel@vger.kernel.org, mann@vmware.com, johnstul@us.ibm.com
Subject: Re: Fix time going backward with clock=pit [1/2]
Message-Id: <20060518011116.68055275.akpm@osdl.org>
In-Reply-To: <20060517160428.62022efd@mann-lx.eng.vmware.com>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Mann <mann@vmware.com> wrote:
>
>  Currently, if you boot with clock=pit on the kernel command line and
>  run a program that loops calling gettimeofday, on many machines you'll
>  observe that time frequently goes backward by about one jiffy.  This
>  patch fixes that symptom and also some other related bugs.

It might be a bit late to get this into 2.6.17.  Although it does look
pretty safe and simple.  

Are many people hitting this problem?

And for 2.6.18 we're hoping to get John's x86 timer rework merged up. 
John, do those patches address this bug?

So if we decide these two patches are not-for-2.6.17 then I'll sit on them
until we decide whether or not to merge John's patches.  If we do, and if
those patches fix this problem then your two patches aren't needed.  If
John's patches don't get merged then I'll need to merge these two.

Hope that all makes sense ;)
