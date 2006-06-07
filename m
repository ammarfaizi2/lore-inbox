Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWFGHEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWFGHEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFGHEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:04:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751093AbWFGHEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:04:07 -0400
Date: Wed, 7 Jun 2006 00:03:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, paulus@samba.org
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
Message-Id: <20060607000348.787b8f16.akpm@osdl.org>
In-Reply-To: <1149662671.27572.158.camel@localhost.localdomain>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<1149652378.27572.109.camel@localhost.localdomain>
	<20060606212930.364b43fa.akpm@osdl.org>
	<1149656647.27572.128.camel@localhost.localdomain>
	<20060606222942.43ed6437.akpm@osdl.org>
	<1149662671.27572.158.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 16:44:31 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> So what can we do ?

Well my plan is to keep being sucky, hence
work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch.

The rule is that sleeping locks need to preserve local IRQs in the
non-contended case.   So be it, move on to more pressing things.
