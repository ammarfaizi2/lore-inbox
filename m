Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUCHTqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUCHTqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:46:38 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:53970 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261162AbUCHTqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:46:36 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: lvm2 performance data with linux-2.6
Date: Mon, 8 Mar 2004 19:46:35 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c2iiir$el4$1@news.cistron.nl>
References: <200403081916.i28JGgE25794@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1078775195 15012 62.216.29.200 (8 Mar 2004 19:46:35 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200403081916.i28JGgE25794@mail.osdl.org>,
 <markw@osdl.org> wrote:
>I've started collecting various data (including oprofile) using our
>DBT-2 (OLTP) workload with lvm2 on linux 2.6.2 and 2.6.3 on ia32 and
>ia64 platforms:
>	http://developer.osdl.org/markw/lvm2/

For write-heavy loads, you might want to see if 2.6.4-rc2-mm1 makes
any difference. It fixes a case where both pdflush and a writing
process itself would queue writes to an LVM device, resulting in
less than optimal I/O ordering for some cases. The fix will probably
be in 2.6.4 proper as well.

Mike.

