Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUHYTWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUHYTWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUHYTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:22:54 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5894 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268329AbUHYTWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:22:50 -0400
Date: Wed, 25 Aug 2004 21:22:46 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/14] kexec: apic-virtwire-on-shutdown.i386.patch
In-Reply-To: <m1u0uu2d4b.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58L.0408252118150.18088@blysk.ds.pg.gda.pl>
References: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.58L.0408231411480.19572@blysk.ds.pg.gda.pl>
 <m1u0uu2d4b.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Eric W. Biederman wrote:

> The local apic still needs to be put into virtual wire mode in that
> case.

 Well, depending on actual wiring you may need to mask LINT0 in this case
to avoid duplicate interrupts.  I think the safest approach would be
remembering the initial values of LVT0 and LVT1 registers of the BSP --
they are just four bytes each, so it would not be a terrible memory waste.

  Maciej
