Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUCBMb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 07:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUCBMb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 07:31:29 -0500
Received: from mta04-svc.ntlworld.com ([62.253.162.44]:45330 "EHLO
	mta04-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261625AbUCBMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 07:31:21 -0500
Date: Tue, 2 Mar 2004 12:31:20 +0000 (GMT)
From: Ben <linux-kernel-junk-email@slimyhorror.com>
X-X-Sender: ben@baphomet.bogo.bogus
To: linux-kernel@vger.kernel.org
Subject: epoll and fork()
Message-ID: <Pine.LNX.4.58.0403021224520.20736@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a defined behaviour for what happens when a process with an epoll
fd forks?

I've an app that inherits an epoll fd from its parent, and then
unregisters some file descriptors from the epoll set. This seems to have
the nasty side effect of unregistering the same file descriptors from the
parent process as well. Surely this can't be right?

This is on 2.6.2.


Ben
