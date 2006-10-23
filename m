Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWJWSmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWJWSmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWJWSmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:42:35 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:49027 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S965010AbWJWSme
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:42:34 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc2-mm2: D-Link DUB-E100 Rev. B broken
Date: Mon, 23 Oct 2006 20:41:48 +0200
User-Agent: KMail/1.9.4
Cc: dhollis@davehollis.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232041.48998.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
D-Link DUB-E100 Rev. B USB Ethernet adapters have worked ok in some recent 
kernels - in rc2-mm2, they're broken again; they're detected correctly and 
the asix module is autoloaded, but after "ifconfig eth0 192.168.0.15 netmask 
255.255.255.0", the box becomes unresponsive and keeps repeating

eth0: Failed to enable software MII access
eth0: Failed to enable hardware MII access
eth0: Failed to enable software MII access
eth0: Failed to enable hardware MII access
eth0: Failed to enable software MII access
eth0: Failed to enable hardware MII access
eth0: Failed to enable software MII access
eth0: Failed to enable hardware MII access
eth0: Failed to enable software MII access
eth0: Failed to enable hardware MII access
eth0: Failed to write Medium Mode to 0x0334: ffffff92

This loops infinitely.

Last known working is 2.6.17 with a patch to bring the asix driver up to the 
14-Jun-2006 revision, first known broken is 2.6.19-rc1-mm1. (I'll try to 
figure out what exact change broke it, but this will take forever on this 
hw).
