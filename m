Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVCZTwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVCZTwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCZTwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 14:52:51 -0500
Received: from fmr24.intel.com ([143.183.121.16]:35559 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261239AbVCZTwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 14:52:49 -0500
Message-Id: <200503261952.j2QJq1g27569@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Oleg Nesterov'" <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Christoph Lameter" <christoph@lameter.com>,
       "Andrew Morton" <akpm@osdl.org>
Subject: RE: [PATCH 0/5] timers: description
Date: Sat, 26 Mar 2005 11:52:01 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUuF8zyfnQnWiW7TWOFdI1wfRtqHgEI3EdA
In-Reply-To: <423ED7E4.2A1F0970@tv-sign.ru>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote on March 19, 2005 17:28:48
> These patches are updated version of 'del_timer_sync: proof of
> concept' 2 patches.

I changed schedule_timeout() to call the new del_timer_sync instead of
currently del_singleshot_timer_sync in attempt to stress these set of
patches a bit more and I just observed a kernel hang.

The symptom starts with lost network connectivity.  It looks like the
entire ethernet connections were gone, followed by blank screen on the
console.  I'm not sure whether it is a hard or soft hang, but system
is inaccessible (blank screen and no network connection). I'm forced
to do a reboot when that happens.


