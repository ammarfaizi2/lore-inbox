Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVBZISo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVBZISo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 03:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVBZISo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 03:18:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:56221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261860AbVBZISD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 03:18:03 -0500
Date: Sat, 26 Feb 2005 00:14:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling call_usermodehelper from interrupt context
Message-Id: <20050226001428.7515d17b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0502261319130.31181@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502261319130.31181@lantana.cs.iitm.ernet.in>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in> wrote:
>
> Is it possible to call call_usermodehelper from interrupt context.

No.  You'll need to run schedule_work() and then run call_usermodehelper()
from within the work function.

