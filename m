Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269451AbUHZTnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbUHZTnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269434AbUHZTj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:39:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269481AbUHZTiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:38:15 -0400
Date: Thu, 26 Aug 2004 12:37:30 -0700
From: "David S. Miller" <davem@redhat.com>
To: Brian Somers <brian.somers@sun.com>
Cc: Michael.Waychison@sun.com, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040826123730.375ce5d2.davem@redhat.com>
In-Reply-To: <412DC055.4070401@sun.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 11:49:57 +0100
Brian Somers <brian.somers@sun.com> wrote:

> Can we get this guy to try running an older version of tg3 to see
> what change introduce the issue?

Brian, we already narrowed it down to exactly the hw autoneg
changes Sun wrote.  It breaks the IBM blades onboard 5704
fibre chips.  Reverting your change or disabling hw autoneg
in the new code both fix the problem.
