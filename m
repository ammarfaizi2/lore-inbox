Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTH1NHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTH1NHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:07:35 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:15341 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264043AbTH1NHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:07:33 -0400
Date: Thu, 28 Aug 2003 06:36:12 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Jamie Lokier <jamie@shareable.org>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>, Timo Sirainen <tss@iki.fi>,
       David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Lockless file reading
In-Reply-To: <20030828130043.GE6800@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0308280635260.14580-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Aug 2003, Jamie Lokier wrote:

> Nagendra Singh Tomar wrote:
> > While the write had "12" in its buffers and it  would have grabbed the
> 
> > page lock to write it into the page cache, won't it set some flag
> saying 
> > that I don't want to be prempted now. I think there is a small
> primitive 
> > for it in from 2.5 onwards. I don't think it will be a good idea to
> prempt 
> > while it is holding the page lock. How is it possible that it just
> wrote 
> > "1" and did not write "2" though it had grabbed the page lock for that
> 
> > purpose. 
> 
> Nope.  I don't see any disabling of preemption while the page is held.
> 
> It wouldn't make sense anyway, because the copies to/from userspace
> can sleep, so there's nothing to gain by disabling preemption.

I understand  what you say. Thanx.

> 
> -- Jamie
> 

