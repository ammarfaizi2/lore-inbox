Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVKMTK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVKMTK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 14:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVKMTK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 14:10:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17888 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750823AbVKMTK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 14:10:56 -0500
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org
In-Reply-To: <200511132000.45836.ak@suse.de>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	 <p734q6g4xuc.fsf@verdi.suse.de>
	 <1131902775.25311.16.camel@localhost.localdomain>
	 <200511132000.45836.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Nov 2005 19:41:42 +0000
Message-Id: <1131910902.25311.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-13 at 20:00 +0100, Andi Kleen wrote:
> It's a bad hack anyways. Better would be probably to use a uncached WC write.
> I would rather use that.

I'm not clear that anything but lock operations have the required
guarantee of atomicity relative to bus masters which are not processors.
Especially so on intel.

