Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUCGNqH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUCGNqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:46:07 -0500
Received: from ns.suse.de ([195.135.220.2]:12717 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261979AbUCGNqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:46:03 -0500
Subject: Re: External kernel modules, second try
From: Andreas Gruenbacher <agruen@suse.de>
To: arjanv@redhat.com
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
In-Reply-To: <1078664629.9812.1.camel@laptop.fenrus.com>
References: <1078620297.3156.139.camel@nb.suse.de>
	 <20040307125348.GA2020@mars.ravnborg.org>
	 <1078664629.9812.1.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1078667199.3594.50.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 07 Mar 2004 14:46:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan,

On Sun, 2004-03-07 at 14:03, Arjan van de Ven wrote:
> > 
> > Could you explain what is the actually gain of using the
> > modversions file your patch creates. (modpost changes)
> 
> distributions don't like to install the vmlinux since it's big(ish) and
> means customers need to download a new vmlinux at each kernel erratum.
> The same information is btw also present in System.map so imo the real
> solution is to make modpost use System.map instead ;)

System.map doesn't have the hashes, and it's missing the symbols from
module files. External modules may require symbols that live in another
module. There are also a number of other minor differences that could
probably be worked around.

Now it would be possible to extract the modver symbols from the
installed vmlinux and .ko files when needed, but note that we may be
building modules for kernels that are not currently running, and for
which those binaries are not even installed. So this sounds like a bad
idea.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

