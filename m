Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbTCMWjE>; Thu, 13 Mar 2003 17:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbTCMWjE>; Thu, 13 Mar 2003 17:39:04 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9339 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262700AbTCMWjD>; Thu, 13 Mar 2003 17:39:03 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303132249.h2DMnj912399@devserv.devel.redhat.com>
Subject: Re: [PATCH] cpu/hw_random cleanups
To: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 13 Mar 2003 17:49:45 -0500 (EST)
Cc: jgarzik@pobox.com (Jeff Garzik), linux-kernel@vger.kernel.org,
       davej@suse.de, alan@redhat.com, torvalds@transmeta.com
In-Reply-To: <3E70E4B8.2010600@zytor.com> from "H. Peter Anvin" at Mar 13, 2003 12:06:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For example, I wonder if storing Intel's cpuid(0x00000001) ecx
> > register output is wise on older Intel cpus.  I worry about garbage
> > appearing there.  Is that a false worry?
> > 
> 
> Yes; it should be completely safe.

I have to admit I'd be more comfortable if we only set those bits IFF
we know they are valid to check, not so much because we need to right now
but out of a desire to make less mistakes possible
