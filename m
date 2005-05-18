Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVERNJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVERNJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVERNJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:09:09 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:46487 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S262108AbVERNJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:09:06 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: linux-kernel@vger.kernel.org
Subject: Recent saa7134 changes create noise when switching channels
Date: Wed, 18 May 2005 15:09:21 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505181509.21537.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using saa7134 with oss=1 (and actually making use of it, e.g. mplayer -tv 
driver=v4l2:device=/dev/video0:adevice=/dev/dsp1:immediatemode=0 tv://1), the 
current driver causes around 2 seconds of noise every time the channel is 
switched (this is with a KNC1 card).

A slightly older version doesn't create the noise; instead, its sound starts a 
bit after the video is playing. Guess the older versions sleep()ed before 
unmuting the OSS device or something.

Any pointers to where to look, assuming I don't have the time to read the full 
diff ATM?

Last known good: 2.6.10-mm2
First known bad: 2.6.12-rc1-mm1

LLaP
bero
