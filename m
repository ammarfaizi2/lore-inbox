Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265619AbUEZPZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUEZPZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbUEZPZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:25:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:17589 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265601AbUEZPZR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 11:25:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>
Subject: Re: 2.6.x kernel sluggish behavior
Date: Thu, 27 May 2004 00:46:16 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <40B49BD6.7050202@vision.ee>
In-Reply-To: <40B49BD6.7050202@vision.ee>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405270046.16429.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 11:29 pm, Lenar Lõhmus wrote:
> Hi.

Hello

> Overall I really like the performance and smoothness of 2.6.x kernels,

Good to hear.

> but there has been always one problematic situation.
>
> It's debian here with X/KDE running. The problem manifests itself
> when one launches acroread-plugin in Mozilla or Mozilla-based browser.

A known case.

> I think it's definetely a scheduler problem (although caused by
> application bug).

This was one of my test cases for applications designed in a certain way that 
makes them prone to priority inversion. I tried extremely hard to find a 
workaround within the kernel and failed to do so. It only manifests with the 
acroread plugin in a gecko browser on uniprocessor, and seems to be some 
interaction within some gdk library if I recall correctly. Look through the 
kernel archives for my description of an earlier version of blender that 
exhibited this same problem. I suspect it's actually the binary only acroread 
and not the gdk library at fault. My solution was to simply make all .pdf 
files launch acroread separately.

Generic solutions for tackling priority inversion prone application designs 
from within the kernel are expensive, and the best solution is to fix the 
application. No doubt a differently designed scheduler would be less prone to 
this particular interaction, but priority inversion is a "feature" of any 
dynamic priority design scheduler to some degree and it is the particular 
application that may or may not hit the resonant frequency (as I like to 
think of it) of each scheduler.

Con
