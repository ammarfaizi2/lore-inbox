Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVDKK6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVDKK6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVDKK6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:58:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65260 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261771AbVDKK6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:58:32 -0400
Date: Mon, 11 Apr 2005 12:57:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, hare@suse.de,
       xfs-masters@oss.sgi.com, nathans@sgi.com, linux-xfs@oss.sgi.com
Subject: swsusp vs. xfs [was Re: 2.6.12-rc2-mm1]
Message-ID: <20050411105759.GB1373@elf.ucw.cz>
References: <20050405175600.644e2453.akpm@osdl.org> <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net> <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net> <20050408103327.GD1392@elf.ucw.cz> <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net> <20050410230053.GD12794@elf.ucw.cz> <20050411043124.GA24626@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411043124.GA24626@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > No, XFS is my root filesystem. :( (Now that I think about it, would
> > > modularizing XFS and using an initrd be OK?)
> > 
> > Yes, loading xfs from initrd should help. [At least it did during
> > suse9.3 testing.]
> 
> Once I modularized xfs and switched to using an initrd, the problem
> disappeared.

I reproduced it locally. Problem is that xfsbufd goes refrigerated,
but someone still tries to wake it up *very* often. Probably something
else in xfs needs refrigerating, too, but I'm not a XFS wizard...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
