Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWE0AJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWE0AJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 20:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWE0AJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 20:09:36 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:58253 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751117AbWE0AJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 20:09:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Date: Sat, 27 May 2006 10:08:41 +1000
User-Agent: KMail/1.9.1
Cc: Folkert van Heusden <folkert@vanheusden.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, wfg@mail.ustc.edu.cn, mstone@mathom.us
References: <348469535.17438@ustc.edu.cn> <20060526235436.GD4294@vanheusden.com> <200605271000.12061.kernel@kolivas.org>
In-Reply-To: <200605271000.12061.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605271008.42137.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 May 2006 10:00, Con Kolivas wrote:
> On Saturday 27 May 2006 09:54, Folkert van Heusden wrote:
> > > > These are nice-looking numbers, but one wonders.  If optimising
> > > > readahead makes this much difference to postgresql performance then
> > > > postgresql should be doing the readahead itself, rather than relying
> > > > upon the kernel's ability to guess what the application will be doing
> > > > in the future.  Because surely the database can do a better job of
> > > > that than the kernel.
> > >
> > > With that argument we should remove all readahead from the kernel?
> > > Because it's already trying to guess what the application will do.
> > > I suspect it's better to have good readahead code in the kernel
> > > than in a zillion application.
> >
> > Maybe a pluggable read-ahead system could be implemented.
>
> Pluggable anything is unpopular with Linus and other maintainers. See
> pluggable cpu scheduler and pluggable page replacement policy (vm)
> patchsets.

Sorry I should have been clearer. The belief is that certain infrastructure 
components do not benefit from a pluggable framework, and readeahead probably 
comes under that description. It's not like Linus was implying we should only 
have one filesystem for example, since filesystems are afterall pluggable 
features.

-- 
-ck
