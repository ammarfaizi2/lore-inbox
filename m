Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbTIVPjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTIVPji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:39:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2800 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263193AbTIVPji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:39:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move slab objects to the end of the real allocation
Date: Mon, 22 Sep 2003 17:33:37 +0200
User-Agent: KMail/1.5.1
Cc: linux-mm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221733.37203.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
>    - Do not page-pad allocations that are <= SMP_CACHE_LINE_SIZE.  This
>      crashes.  Right now the limit is hardcoded to 128 bytes, but sooner or
>      later an arch will appear with 256 byte cache lines.

What made you think that 128 is the current maximum? All s390 machines
have 256 byte cache lines.

	Arnd <><
