Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRCHQCD>; Thu, 8 Mar 2001 11:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRCHQBy>; Thu, 8 Mar 2001 11:01:54 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:63487 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129184AbRCHQBu>; Thu, 8 Mar 2001 11:01:50 -0500
Message-Id: <200103081651.f28GpkQ04042@513.holly-springs.nc.us>
Subject: opening files in /proc, and modules
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.06.23.22 - Preview Release)
Date: 08 Mar 2001 11:01:28 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I detect that open() has been called on a file in procfs that a
module provides? If I modprobe my module, open one or more if its proc
entries, then rmmod the module while the proc files are still open, then
the deletion of those entries is deferred. When I close the file(s), the
kernel oopses. I need to be able to detect open() and close() in order
to increment/decrement the reference count for my module, to prevent it
from being rmmoded when in use. Any tips?

Thanks! 

