Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTEGEqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbTEGEqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:46:06 -0400
Received: from rth.ninka.net ([216.101.162.244]:36237 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262855AbTEGEqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:46:03 -0400
Subject: Re: tg3 - irq #: nobody cared!
From: "David S. Miller" <davem@redhat.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <1052258580.4495.12.camel@w-jstultz2.beaverton.ibm.com>
References: <1052258580.4495.12.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052283509.9817.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 21:58:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 15:03, john stultz wrote:
> 	Not sure if this is the proper fix, but it stops the kernel from
> complaining. I saw Andrew suggest something similar for a sound driver.

Definitely not the right fix.  If the hardware status struct
indicates no event is pending, then we return 0 since we
didn't "handle" the interrupt.

Otherwise, whats the point of the irqreturn_t at all? :-)

-- 
David S. Miller <davem@redhat.com>
