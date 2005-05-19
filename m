Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVESRpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVESRpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVESRpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:45:52 -0400
Received: from [81.2.110.250] ([81.2.110.250]:39306 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261185AbVESRpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:45:35 -0400
Subject: Re: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01
	when RT program dumps core]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dwalker@mvista.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@osdl.org>,
       kus Kusche Klaus <kus@keba.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116523552.14229.64.camel@dhcp153.mvista.com>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
	 <1116509820.15866.28.camel@localhost.localdomain>
	 <1116523552.14229.64.camel@dhcp153.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116524583.21388.299.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 May 2005 18:43:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-05-19 at 18:25, Daniel Walker wrote:
> I've seen a RT yield warning on this yield while running the FUSYN
> tests .. I can't imagine why it's there either.

Would it not make more sense to kick a task out of hard real time at the
point it begins dumping core. The core dumping sequence was never
something that thread intended to execute at real time priority

