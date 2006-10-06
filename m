Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWJFOor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWJFOor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWJFOor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:44:47 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:55969
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1161014AbWJFOoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:44:46 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Fri, 6 Oct 2006 16:44:32 +0200
User-Agent: KMail/1.9.4
References: <200610052059.11714.mb@bu3sch.de> <1160085480.1607.32.camel@localhost.localdomain>
In-Reply-To: <1160085480.1607.32.camel@localhost.localdomain>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061644.33267.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 23:58, Alan Cox wrote:
> Ar Iau, 2006-10-05 am 20:59 +0200, ysgrifennodd Michael Buesch:
> > Is is really a good idea to allow processes to remap something
> > to address 0?
> 
> It is very useful indeed. Consider for example dosemu.

Ok, good point.

> > Besides that, I currently don't see a valid reason to mmap address 0.
> > 
> > Comments?
> 
> User zero is not neccessarily mapped at kernel zero so your argument
> isn't portable either.

Eh, so what about the following.
We _have_ arches which map user zero to kernel zero. What about
specialcasing that on a per-arch case. So remapping user zero to
something else in kernel.

-- 
Greetings Michael.
