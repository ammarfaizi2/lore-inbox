Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUELS37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUELS37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUELS37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:29:59 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:41352 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265161AbUELS35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:29:57 -0400
Date: Wed, 12 May 2004 11:29:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: richard.coe@med.ge.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: finding floating point use in the kernel
Message-ID: <20040512182951.GA4796@taniwha.stupidest.org>
References: <200405121802.NAA26824@neo.gso.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405121802.NAA26824@neo.gso.med.ge.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 01:02:45PM -0500, richard.coe@med.ge.com wrote:

> While trying to track down a problem with some floating point
> calculations, I wrote the following script.  Perhaps someone can add
> it to the kernel Makefile to run when the Platform is I386.

As was just pointed out to me, this finds instructions which are never
executed (they are just part of alignment/padding) and decodes them
resulting in false positives.

Christoph pointed out -mm has -msoft-float which I think should be
sufficient to catch anything bad going on by accident.


  --cw
