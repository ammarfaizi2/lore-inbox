Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbULaSCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbULaSCB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbULaSCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:02:00 -0500
Received: from [195.23.16.24] ([195.23.16.24]:37863 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262130AbULaSB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:01:58 -0500
Message-ID: <1104515971.41d593835721f@webmail.grupopie.com>
Date: Fri, 31 Dec 2004 17:59:31 +0000
From: "" <pmarques@grupopie.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: "" <linux-kernel@vger.kernel.org>, "" <kaos@ocs.com.au>,
       "" <sam@ravnborg.org>
Subject: Re: sh: inconsistent kallsyms data
References: <20041231172549.GA18211@linux-sh.org>
In-Reply-To: <20041231172549.GA18211@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.89.203
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Mundt <lethal@linux-sh.org>:

> Building 2.6.10 for sh results in inconsistent kallsyms data. Turning on
> CONFIG_KALLSYMS_ALL fixes it, as does CONFIG_KALLSYMS_EXTRA_PASS.

I think the only change from 2.6.9 that could affect this is the addition of the
is_arm_mapping_symbol from Russel King.

Can you try to comment out this function in scripts/kallsyms.c (and the call to
it in read_symbol) and see if it changes the result for you?

--
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu
