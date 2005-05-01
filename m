Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVEAQOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVEAQOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEAQKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 12:10:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35240 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261695AbVEAQGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 12:06:50 -0400
Date: Sun, 1 May 2005 17:07:07 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org, sam@ravnborg.org,
       Ryan Anderson <ryan@michonline.com>
Subject: Re: [uml-devel] Re: [UML] Compile error when building with seperate source and object directories
Message-ID: <20050501160707.GI13052@parcelfarce.linux.theplanet.co.uk>
References: <1114570958.5983.50.camel@mythical> <20050428202647.GA25451@ccure.user-mode-linux.org> <20050428215328.GC13052@parcelfarce.linux.theplanet.co.uk> <200505011330.58205.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505011330.58205.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 01:30:57PM +0200, Blaisorblade wrote:
> For now I've added an #ifdef to re-include that code for x86, while excluding 
> it for x86_64. Also, is that up-to-date wrt. 2.6.12-rc3?

Yes, it is.  As for the ptrace.c...  IMO the right thing is per-architecture
helper here.  Such ifdefs are OK when it's just i386 and amd64.  As soon
as e.g. uml/s390 gets merged or uml/ia64 and uml/ppc get resurrected...
