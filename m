Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280934AbRKOQqK>; Thu, 15 Nov 2001 11:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280940AbRKOQqA>; Thu, 15 Nov 2001 11:46:00 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:30986
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S280934AbRKOQpv>; Thu, 15 Nov 2001 11:45:51 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111151623.fAFGN0o03243@www.hockin.org>
Subject: Re: 32 Groups Maximum in 2.4
To: reynolds@redhat.com (Tommy Reynolds)
Date: Thu, 15 Nov 2001 08:22:59 -0800 (PST)
Cc: jackie.m@vt.edu (Jackie Meese), linux-kernel@vger.kernel.org
In-Reply-To: <20011115094116.290282cc.reynolds@redhat.com> from "Tommy Reynolds" at Nov 15, 2001 09:41:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've been looking for some time on how to raise the maximum number of 
> > groups for the 2.4 kernel.  I've discovered how to do this kernel, with 
> > a discussion a few months ago on this 
> > list.http://www.cs.helsinki.fi/linux/linux-kernel/2001-13/0807.html
> 
> Look at the file "include/asm-<proc>/param.h to find the symbol "NGROUPS".
> Change that to whatever value you like.



We have a patch that we haven't submitted yet (out of mostlyt cowardice)
that makes this fully dynamic.  task->groups is dynamically allocated and
handled, and can grow up to a sysctl() defined maximum.

It has been working wonderfully for 10,000+ groups.  Does this patch have a
chance in hell of going standard?? (don't have the patch on hand, or I'd post
it).
