Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUCOIRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 03:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCOIRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 03:17:37 -0500
Received: from mail.shareable.org ([81.29.64.88]:18060 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262325AbUCOIRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 03:17:36 -0500
Date: Mon, 15 Mar 2004 08:17:13 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040315081713.GB7188@mail.shareable.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> What for? It should be invisible to userspace...

It's not invisible.  select/poll/epoll/setitimer round their time
argument according to HZ, and programs which do smooth (i.e. low
_jitter_) animation of the kind where the eye is sensitive to the
jitter need to track it and correct for it.

-- Jamie
