Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUJWIgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUJWIgW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 04:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUJWIgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 04:36:22 -0400
Received: from lucidpixels.com ([66.45.37.187]:30102 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S266892AbUJWIgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 04:36:01 -0400
Date: Sat, 23 Oct 2004 04:35:59 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Page Allocation Failures Return With 2.6.9+TSO patch.
Message-ID: <Pine.LNX.4.61.0410230435150.4620@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.9 w/TSO patch.

(most likely do to the e1000/nic/issue)

$ dmesg
gaim: page allocation failure. order:4, mode:0x21
  [<c01391a7>] __alloc_pages+0x247/0x3b0
  [<c0139328>] __get_free_pages+0x18/0x40
  [<c035c33a>] sound_alloc_dmap+0xaa/0x1b0
  [<c03648c0>] ad_mute+0x20/0x40
  [<c035c70f>] open_dmap+0x1f/0x100
  [<c035cb58>] DMAbuf_open+0x178/0x1d0
  [<c035a4fa>] audio_open+0xba/0x280
  [<c015d863>] cdev_get+0x53/0xc0
  [<c035968c>] sound_open+0xac/0x110
  [<c035898e>] soundcore_open+0x1ce/0x300
  [<c03587c0>] soundcore_open+0x0/0x300
  [<c015d524>] chrdev_open+0x104/0x250
  [<c015d420>] chrdev_open+0x0/0x250
  [<c0152d82>] dentry_open+0x1d2/0x270
  [<c0152b9c>] filp_open+0x5c/0x70
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c0152e75>] get_unused_fd+0x55/0xf0
  [<c0152fd9>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:4, mode:0x21
  [<c01391a7>] __alloc_pages+0x247/0x3b0
  [<c0139328>] __get_free_pages+0x18/0x40
  [<c035c33a>] sound_alloc_dmap+0xaa/0x1b0
  [<c03648c0>] ad_mute+0x20/0x40
  [<c035c70f>] open_dmap+0x1f/0x100
  [<c035ca9d>] DMAbuf_open+0xbd/0x1d0
  [<c035a4fa>] audio_open+0xba/0x280
  [<c015d863>] cdev_get+0x53/0xc0
  [<c035968c>] sound_open+0xac/0x110
  [<c035898e>] soundcore_open+0x1ce/0x300
  [<c03587c0>] soundcore_open+0x0/0x300
  [<c015d524>] chrdev_open+0x104/0x250
  [<c015d420>] chrdev_open+0x0/0x250
  [<c0152d82>] dentry_open+0x1d2/0x270
  [<c0152b9c>] filp_open+0x5c/0x70
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c0152e75>] get_unused_fd+0x55/0xf0
  [<c0152fd9>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:4, mode:0x21
  [<c01391a7>] __alloc_pages+0x247/0x3b0
  [<c0139328>] __get_free_pages+0x18/0x40
  [<c035c33a>] sound_alloc_dmap+0xaa/0x1b0
  [<c03648c0>] ad_mute+0x20/0x40
  [<c035c70f>] open_dmap+0x1f/0x100
  [<c035cb58>] DMAbuf_open+0x178/0x1d0
  [<c035a4fa>] audio_open+0xba/0x280
  [<c035968c>] sound_open+0xac/0x110
  [<c035898e>] soundcore_open+0x1ce/0x300
  [<c03587c0>] soundcore_open+0x0/0x300
  [<c015d524>] chrdev_open+0x104/0x250
  [<c015d420>] chrdev_open+0x0/0x250
  [<c0152d82>] dentry_open+0x1d2/0x270
  [<c0152b9c>] filp_open+0x5c/0x70
  [<c0152e75>] get_unused_fd+0x55/0xf0
  [<c0152fd9>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:4, mode:0x21
  [<c01391a7>] __alloc_pages+0x247/0x3b0
  [<c0139328>] __get_free_pages+0x18/0x40
  [<c035c33a>] sound_alloc_dmap+0xaa/0x1b0
  [<c03648c0>] ad_mute+0x20/0x40
  [<c035c70f>] open_dmap+0x1f/0x100
  [<c035ca9d>] DMAbuf_open+0xbd/0x1d0
  [<c035a4fa>] audio_open+0xba/0x280
  [<c035968c>] sound_open+0xac/0x110
  [<c035898e>] soundcore_open+0x1ce/0x300
  [<c03587c0>] soundcore_open+0x0/0x300
  [<c015d524>] chrdev_open+0x104/0x250
  [<c015d420>] chrdev_open+0x0/0x250
  [<c0152d82>] dentry_open+0x1d2/0x270
  [<c0152b9c>] filp_open+0x5c/0x70
  [<c0152e75>] get_unused_fd+0x55/0xf0
  [<c0152fd9>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
$
