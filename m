Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422724AbWHYPod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWHYPod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWHYPoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:44:32 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:29856 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422717AbWHYPo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:44:29 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Indan Zupancic <indan@nul.nu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Fri, 25 Aug 2006 17:39:46 +0200
Message-Id: <20060825153946.24271.42758.sendpatchset@twins>
Subject: [PATCH 0/4] VM deadlock prevention -v5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The latest version of the VM deadlock prevention work.

The basic premises is that network sockets serving the VM need undisturbed
functionality in the face of severe memory shortage.

This patch-set provides the framework to provide this.
