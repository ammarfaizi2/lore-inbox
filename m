Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVHISZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVHISZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVHISZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:25:49 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.4.205]:25190 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964921AbVHISZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:25:48 -0400
Date: Tue, 09 Aug 2005 14:26:56 -0400
From: Robert Wilkens <robw@optonline.net>
Subject: Re: Signal handling possibly wrong
In-reply-to: <42F8EB66.8020002@fujitsu-siemens.com>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1123612016.3167.3.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.2.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <42F8EB66.8020002@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel code blocks both "handled signal" _and_ sa_mask only if SA_NODEFER
> isn't set.
> 
> Which is the right behavior?

Perhaps both?

I'm novice here, but if i'm reading the man page correctly, it says:

SA_NODEFER
   Do not prevent the signal from being received from within
   its  own  signal handler. 
	(they also imply that SA_NOMASK is the old name for this,
	which might make it clear what it's use is).

In which case blocking (masking) when it's not set is exactly what it's
supposed to do.

-Rob

