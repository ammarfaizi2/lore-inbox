Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbUK2WoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUK2WoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbUK2WoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:44:00 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57006 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261861AbUK2WnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:43:19 -0500
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, riel@redhat.com, mason@suse.com,
       ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management 
In-reply-to: Your message of Mon, 29 Nov 2004 12:23:58 PST.
             <20041129122358.02593a2a.akpm@osdl.org> 
Date: Mon, 29 Nov 2004 14:33:32 -0800
Message-Id: <E1CYu5M-00015C-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 12:23:58 PST, Andrew Morton wrote:
> Gerrit Huizenga <gh@us.ibm.com> wrote:
> >
> > The following ten patches add the core of CKRM (Class Based Resource
> > Management) to Linux.
> 
> How useful is this code at present?  What are its limitations?  And what is
> the plan for future enhancements?

This set of code alone allows for creation of classes which include
per-class resource accounting (including delay accounting), basic
task management for memory, CPU and disk IO, limited socket & listener
queue management for networking, and the related rules based infrastructure.

So, in short, it is a useful set of code to work with to demonstrate
real utility with CKRM.  However, this submission is not as full featured
as is being used by those on the ckrm-tech list, such as the PlanetLab
work.  There are also things in SLES9 that are more featureful than
this set although those will be worked into here in time.

It does not have the full memory management and scheduler support that
other versions do and I'm not yet convinced that those are ready to
submit.  Future enhancements will start with the cleanups as recommended
by lkml so far (thanks all ;-) followed by more work on the scheduler
and memory management side in the short term.  There are also ways
to hook in additional resource controllers for any exhaustible resource,
e.g. file handles. setrlimit style resources, etc.

Most of the next level of changes will build on these and are based
on work currently in progress on the ckrm-tech list.  However, this is
a stripped down set of code which is believed to be stable (tested on
IA32, x86-64, PPC64) with a variety of config options using both
standard regression suites (e.g. LTP, kernbench, the ckrm tests, etc.).

gerrit
