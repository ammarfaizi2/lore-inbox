Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbUCMWLb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbUCMWLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:11:30 -0500
Received: from napo.bezeqint.net ([192.115.104.9]:25563 "EHLO
	napo.bezeqint.net") by vger.kernel.org with ESMTP id S263200AbUCMWL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:11:28 -0500
Date: Sun, 14 Mar 2004 00:10:19 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040313221018.GE5960@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079198671.4446.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 06:24:31PM +0100, Arjan van de Ven wrote:
> On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> > Is it possible to find out what the kernel's notion of HZ is from user
> > space?
> > It seem to change from system to system and between 2.4 (100 on i386)
> > to 2.6 (1000 on i386).
> 
> if you can see 1000 from userspace that is a bad kernel bug; can you say
> where you find something in units of 1000 ?

I can't see it from user space. Its in the kernel headers. The thing is
I am working on fixes to laptop mode. The problem is it requires
changing bdflush and journaled file systems journal flush times. The
problem is that some of these (bdflush, xfs) expect the value in jiffies
and not seconds or milliseconds so making the initiation script portable
requires knowing the value of HZ.

