Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWADJL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWADJL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWADJL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:11:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19117 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751623AbWADJL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:11:28 -0500
Date: Wed, 4 Jan 2006 10:11:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
In-Reply-To: <43BB1178.7020409@cosmosbay.com>
Message-ID: <Pine.LNX.4.61.0601041010180.29257@yvahk01.tjqt.qr>
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com>
 <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com>
 <43BB1178.7020409@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) Reduces the size of (files_struct), using a special 32 bits (or 64bits)
> embedded_fd_set, instead of a 1024 bits fd_set for the close_on_exec_init and
> open_fds_init fields. This save some ram (248 bytes per task)


> as most tasks dont open more than 32 files.

How do you know, have you done some empirical testing?



Jan Engelhardt
-- 
