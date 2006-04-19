Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDSGbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDSGbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDSGbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:31:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750782AbWDSGbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:31:33 -0400
Date: Tue, 18 Apr 2006 23:30:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-acpi@vger.kernel.org, linux@dominikbrodowski.net,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] -mm: acpi idle __read_mostly and de-init static var
Message-Id: <20060418233041.272264b6.akpm@osdl.org>
In-Reply-To: <20060418190045.GA25749@rhlx01.fht-esslingen.de>
References: <20060418190045.GA25749@rhlx01.fht-esslingen.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
>
> - don't remove static init value of nocst and bm_history
>    since __read_mostly may be special
>    (see e.g. http://www.ussg.iu.edu/hypermail/linux/kernel/0010.0/0771.html)
> 

hm, that was six years ago.  I'm vaguely surprised that the initialisation
was needed even then.  It isn't needed now.  Or if it is, we need to find
out why and fix it.

