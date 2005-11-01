Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVKAMRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVKAMRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKAMRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:17:01 -0500
Received: from [81.2.110.250] ([81.2.110.250]:39911 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750775AbVKAMRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:17:01 -0500
Subject: Re: PATCH: EDAC - clean up atomic stuff
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Doug Thompson <dthompson@lnxi.com>
In-Reply-To: <m18xw88thu.fsf@ebiederm.dsl.xmission.com>
References: <1129902050.26367.50.camel@localhost.localdomain>
	 <m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
	 <1130772628.9145.35.camel@localhost.localdomain>
	 <m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
	 <20051031120254.4579dc9a.akpm@osdl.org>
	 <m18xw88thu.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Nov 2005 12:46:39 +0000
Message-Id: <1130849199.9145.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a much more serious bug there as well.  The code as it
> exists is flatly impossible on x86_64 and some other architectures
> as they do not support kmap.  It is also broken on x86 as grain can

All platforms have kmap. On systems without "highmem" the kmap functions
simply return the page address of the existing permanent physical
mapping for the page. See include/linux/highmem.h

So it's all fine and larger than page sized scrubs can be added to the
core code when they are needed.

Alan

