Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWEKMkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWEKMkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 08:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWEKMkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 08:40:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44708 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751655AbWEKMkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 08:40:23 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] add slab_is_available() routine for boot code
Date: Thu, 11 May 2006 14:40:16 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, penberg@cs.helsinki.fi, clameter@sgi.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org
References: <20060510205543.GI3198@w-mikek2.ibm.com> <20060510155026.173c57a1.akpm@osdl.org> <20060510230054.GA11214@w-mikek2.ibm.com>
In-Reply-To: <20060510230054.GA11214@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200605111440.17239.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 01:00, Mike Kravetz wrote:
> On Wed, May 10, 2006 at 03:50:26PM -0700, Andrew Morton wrote:
> >
> > Is this a needed-for-2.6.17 fix?
> 
> I'll let Arnd answer.  He ran into this when doing some Cell work.  Not
> sure where in the development cycle the code is that exposes this bug.

The code in 2.6.17 breaks when spufs is non-modular. Currently, this is
a compile-time option so users can work around it by building spufs
as a loadable module.

For 2.6.18, we want to make the part of spufs that calls this
non-modular in order to avoid adding further EXPORT_SYMBOLs. I would
much prefer to have the fix in 2.6.17 already, but we could
alternatively force spufs to be a loadable module in 2.6.17 and
change it later.

	Arnd <><
