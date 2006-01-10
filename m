Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWAJA73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWAJA73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWAJA73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:59:29 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:49610 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932133AbWAJA72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:59:28 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1136834210.6197.10.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20060107033637.458c4716.akpm@osdl.org>
	 <1136834210.6197.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 19:59:21 -0500
Message-Id: <1136854761.6197.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, 

FYI

I just uploaded my 2.6.15-rt2-sr3 which includes the latest patch to fix
the bug in remove_proc_entry.

http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt2-sr3

Again, the module to test this is here:

http://www.kihontech.com/tests/proc/proc_stress.c

I tested it like the following:

# insmod proc_stress.ko & for i in `seq 1 10000`; do ls /proc/proc_tests; done

-- Steve


