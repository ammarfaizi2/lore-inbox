Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbULRQSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbULRQSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 11:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbULRQSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 11:18:25 -0500
Received: from main.gmane.org ([80.91.229.2]:42644 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261198AbULRQR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 11:17:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joseph Seigh" <jseigh_02@xemaps.com>
Subject: What does atomic_read actually do?
Date: Sat, 18 Dec 2004 11:23:37 -0500
Message-ID: <opsi7o5nqfs29e3l@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't do anything that would actually guarantee that the fetch from
memory would be atomic as far as I can see, at least in the x86 version.
The C standard has nothing to say about atomicity w.r.t. multithreading or
multiprocessing.  Is this a gcc compiler thing?  If so, does gcc guarantee
that it will fetch aligned ints with a single instruction on all platforms
or just x86?   And what's with volatile since if the C standard implies
nothing about multithreading then it follows that volatile has no meaning
with respect to multithreading either?  Also a gcc thing?  Are volatile
semantics well defined enough that you can use it to make the compiler
synchronize memory state as far as it is concerned?

Joe Seigh

