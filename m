Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVCALNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVCALNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVCALNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:13:24 -0500
Received: from imap.gmx.net ([213.165.64.20]:51635 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261872AbVCALNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:13:16 -0500
X-Authenticated: #26200865
Message-ID: <42244EDD.9020204@gmx.net>
Date: Tue, 01 Mar 2005 12:15:41 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: updating mtime for char/block devices?
References: <42225CEE.1030104@gmx.net> <1109576878.6298.49.camel@laptopd505.fenrus.org> <4223BB3B.4060309@gmx.net> <20050301093709.A29817@flint.arm.linux.org.uk>
In-Reply-To: <20050301093709.A29817@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King schrieb:
> On Tue, Mar 01, 2005 at 01:45:47AM +0100, Carl-Daniel Hailfinger wrote:
> 
>>Can I prevent mtime updates for all device files? Mounting /dev readonly
>>would certainly help, but for that to work I'd have to move /dev to a
>>different filesystem, right?
> 
> 
> tty mtime updates aren't marked dirty, so aren't written back to disk.
> Intentionally.

It seems the tty mtime exception doesn't include /dev/ptmx. That's
probably unintentional. Is there a chance to extend the tty mtime
exception to all char devices or at least major 4+5?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
