Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVBAJOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVBAJOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVBAJMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:12:22 -0500
Received: from mailgate.hob.de ([62.91.19.101]:49564 "EHLO mailgate.hob.de")
	by vger.kernel.org with ESMTP id S261870AbVBAJFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:05:11 -0500
Message-ID: <41FF45EA.5010908@hob.de>
Date: Tue, 01 Feb 2005 10:03:38 +0100
From: Christian Hildner <christian.hildner@hob.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: de-de, de
MIME-Version: 1.0
To: baswaraj kasture <kbaswaraj@yahoo.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: Kernel 2.4.21 hangs up
References: <20050201082001.43454.qmail@web51102.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

baswaraj kasture schrieb:

>Hi,
>
>I compiled kernel 2.4.21 with intel compiler .
>While booting it hangs-up . further i found that it
>hangsup due to call to "calibrate_delay" routine in
>"init/main.c". Also found that loop in the
>callibrate_delay" routine goes infinite.When i comment
>out the call to "callibrate_delay" routine, it works
>fine.Even compiling "init/main.c" with "-O0" works
>fine. I am using IA-64 (Intel Itanium 2 ) with EL3.0.
>
>Any pointers will be great help.
>
- Download ski from http://www.hpl.hp.com/research/linux/ski/download.php
- Compile your kernel for the simulator
- set simulator breakpoint at calibrate_delay
- look at ar.itc and cr.itm (cr.itm must be greater than ar.itc)

Or for debugging on hardware:
-run into loop, press the TOC button, reboot and analyze the dump with 
efi shell + errdump init

Christian

