Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUKLTCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUKLTCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUKLTCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:02:36 -0500
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:6607 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262616AbUKLTCQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:02:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] handle quoted module parameters
Date: Fri, 12 Nov 2004 12:02:10 -0700
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AF0@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] handle quoted module parameters
Thread-Index: AcTIbqK/jkXcqa/GSIyqBFMGLgaOogAeHyDg
From: <yiding_wang@agilent.com>
To: <rddunlap@osdl.org>
Cc: <yiding_wang@agilent.com>, <arjan@infradead.org>,
       <linux-kernel@vger.kernel.org>, <rusty@rustcorp.com.au>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 12 Nov 2004 19:02:11.0140 (UTC) FILETIME=[1D391840:01C4C8EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

Thanks for your two responses!

Based on your patch, the format of argument will be changed from standard format before:
Used to be:
modprm1=first,ext modprm2=second,ext modprm3="third1,ext third2,ext"
where the quotation in modprm3 represents the whole string, including space, to be the value of third parameter modprm3.

Now the patch changes modprm3 to "modprm3=third1,ext third2,ext" which equivalent to putting quotation mark on normal parameter define "modprm1=first,ext". Do you think linux community will take that change?

Another question is the parameter length is not limited in 2.4.x kernel. Why this is restricted under 2.6.x. (param_set_charp())?

Regards,

Eddie


-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org]
Sent: Thursday, November 11, 2004 8:17 PM
To: Randy.Dunlap
Cc: yiding_wang@agilent.com; arjan@infradead.org;
linux-kernel@vger.kernel.org; rusty@rustcorp.com.au; akpm
Subject: [PATCH] handle quoted module parameters


Here's a patch with better description.


Fix module parameter quote handling.
Module parameter strings (with spaces) are quoted like so:
"modprm=this test"
and not like this:
modprm="this test"

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  kernel/params.c |   15 ++++++++++++---
  1 files changed, 12 insertions(+), 3 deletions(-)


-- 
~Randy
