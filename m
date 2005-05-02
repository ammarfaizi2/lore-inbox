Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVEBTOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVEBTOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVEBTOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:14:47 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:18845 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261718AbVEBTOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:14:44 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [uml-devel] Re: [UML] Compile error when building with seperate source and object directories
Date: Mon, 2 May 2005 21:14:05 +0200
User-Agent: KMail/1.8
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org, sam@ravnborg.org,
       Ryan Anderson <ryan@michonline.com>
References: <1114570958.5983.50.camel@mythical> <200505011330.58205.blaisorblade@yahoo.it> <20050501160707.GI13052@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050501160707.GI13052@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505022114.06062.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 May 2005 18:07, Al Viro wrote:
> On Sun, May 01, 2005 at 01:30:57PM +0200, Blaisorblade wrote:
> > For now I've added an #ifdef to re-include that code for x86, while
> > excluding it for x86_64. Also, is that up-to-date wrt. 2.6.12-rc3?
>
> Yes, it is.  As for the ptrace.c...  IMO the right thing is
> per-architecture helper here.  Such ifdefs are OK when it's just i386 and
> amd64.  As soon as e.g. uml/s390 gets merged or uml/ia64 and uml/ppc get
> resurrected...
Agreed, I've done it this way to reintroduce for now the code for i386. It's 
anyway kludgy, since amd64 has too its debug registers to handle (at least it 
should); it's just that UML does not handle them yet.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

