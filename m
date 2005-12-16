Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVLPVLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVLPVLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLPVLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:11:01 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:34522 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932197AbVLPVLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:11:00 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Dave Hansen <haveblue@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Matt Helsley <matthltc@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <E1EnMSU-0004pH-00@w-gerrit.beaverton.ibm.com>
References: <E1EnMSU-0004pH-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 13:10:54 -0800
Message-Id: <1134767454.19403.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 12:45 -0800, Gerrit Huizenga wrote:
> Interesting...  So how to tasks get *into* a container?

Only by inheritance.  

> And can they ever get back "out" of a container?

No.  Think of the pids again.  Even the "outside" of a container, things
like the real init, have to have unique pids.  What if the process's pid
is the same as one in use in the default container?

> Are most processes on the system
> initially not in a container?  And then they can be stuffed in a container?
> And then containers can be moved around or be isolated from each other?

The current idea is that processes are assigned at fork-time.  The
isolation is for the lifetime of the process.

> And, is pid virtualization the point where this happens?  Or is that
> a slightly higher level?  In other words, is pid virtualization the
> full implementation of container isolation?  Or is it a significant
> element on which additional policy, restrictions, and usage models
> can be built?

pid virtualization is simply the one that's easiest to understand, and
the one that demonstrates the largest number of issues.  It is a small
piece of the puzzle, but an important one.

-- Dave

