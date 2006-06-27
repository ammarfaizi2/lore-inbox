Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWF0Xg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWF0Xg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWF0Xg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:36:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:44186 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932183AbWF0Xg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:36:29 -0400
Date: Tue, 27 Jun 2006 16:37:02 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com, oleg@tv-sign.ru
Subject: [PATCH 0/2] srcu-2: add RCU variant that permits read-side blocking
Message-ID: <20060627233702.GA2696@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated based on review comments from Andrew and Oleg (thank you!).

Oleg's bug did turn out to be real (thank you, Oleg!!!), so this patch
contains an alleged fix.  It passes a short rcutorture run on x86 and
ppc64, but so did the previous one (more intense testing in the offing).
This patchset depends on the earlier ops-ization of the rcutorture
infrastructure.

As before, series includes:

o	Addition of SRCU primitives and documentation.

o	Addition of SRCU operations to rcutorture.

							Thanx, Paul
