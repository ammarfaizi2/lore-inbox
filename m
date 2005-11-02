Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVKBPz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVKBPz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVKBPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:55:56 -0500
Received: from denise.shiny.it ([194.20.232.1]:65472 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S965101AbVKBPzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:55:55 -0500
Date: Wed, 2 Nov 2005 16:55:47 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Alex Lyashkov <umka@sevcity.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Would I be violating the GPL?
In-Reply-To: <1130943242.3367.39.camel@berloga.shadowland>
Message-ID: <Pine.LNX.4.58.0511021653270.28061@denise.shiny.it>
References: <XFMail.20051102104916.pochini@shiny.it>
 <1130943242.3367.39.camel@berloga.shadowland>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Nov 2005, Alex Lyashkov wrote:

> > Linux 2.6 doesn't accept c++, so you have to rewrite it anyway.
> > You should ask them if you can publish your own driver based
> > on infos you extract from their driver.
> >
> without exeption c++ code can be used at drivers.

No, it can't. There is not support at all for c++ in the kernel. Even if
you don't use exceptions and you redefine all new() operators, when you
try to load the module it will not find several symbols that are defined
inside user space libraries. Under 2.4 I managed to use c++ code in a
module, but I had to define some 100% bogus symbols in the sources to make
the loader happy (those symbols are gcc- and architecture-dependent).
Furthermore, c++ code can crash because c++ hides too many things,
expecially temporary stuff which is allocated on the stack. Stack space in
*very* limited in kernel space. Finally, linux 2.6 do not permit loading
c++ code anymore.

--
Giuliano.
