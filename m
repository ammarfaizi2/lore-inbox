Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUEAVAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUEAVAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 17:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUEAVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 17:00:23 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:37045 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262406AbUEAVAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 17:00:20 -0400
From: Lev Makhlis <mlev@despammed.com>
To: "Andi Kleen" <ak@muc.de>, "Michael Brown" <mebrown@michaels-house.net>
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
Date: Sat, 1 May 2004 16:00:44 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405011700.44518.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -- This information is, in the very near future, _not_ going to be
> > static anymore. There will be systems that update the information in
> > dynamically during SMIs.
>
> That's fine - /dev/mem can handle that too. An user will have to
> poll for changes anyways, so having it it /proc does not have
> any advantages.

One problem is that /dev/mem access isn't atomic.  You need to read
a pointer, then follow the pointer to read data.  If the pointer changes
in the middle, you lose.  That said, I don't see any mechanism that
helps avoid that in kernel, either.

