Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVCVCvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVCVCvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVCVCsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:48:50 -0500
Received: from mail.inter-page.com ([207.42.84.180]:24070 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262551AbVCVCqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:46:46 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Chris Friesen'" <cfriesen@nortel.com>,
       "'Jan Engelhardt'" <jengelh@linux01.gwdg.de>
Cc: "'Jesper Juhl'" <juhl-lkml@dif.dk>, <linux-kernel@vger.kernel.org>
Subject: RE: Short sleep precision
Date: Mon, 21 Mar 2005 18:46:26 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAAlDt+0fVi0uunPYaX9zoXQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <423EF7B5.2030507@nortel.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually look at linux/Documentation/rtc.txt for a "reasonably portable" way to get
very small quanta with fair regularity.

Since the original poster wanted it to be user accessible, and since it is a
contended/exclusive device, he may want to make a broker daemon or something.

Since nanosleep doesn't constrain the max time of the sleep, you get the same
performance by setting the timer the "a good way" and then spinning on it from user
space, or blocking or whatever.  Confabulating the right thing to do for
non-power-of-2 times is pretty trivial too.

Not perfect, but trying to be all things to all people, and all that... 8-)


Rob White,
Casabyte, Inc.


