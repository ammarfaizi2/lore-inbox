Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbUK0U43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUK0U43 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUK0U43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 15:56:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64697 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261325AbUK0U4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 15:56:02 -0500
Date: Sat, 27 Nov 2004 21:56:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernard Normier <bernard@zeroc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <006001c4d4c2$14470880$6400a8c0@centrino>
Message-ID: <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr>
References: <006001c4d4c2$14470880$6400a8c0@centrino>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As long as I serialize access to /dev/urandom, I get different values.
>However, with concurrent access to /dev/urandom, I quickly get duplicate

How do you concurrently read from urandom? That's only possible with 2 or more
CPUs, and even then, I hope that the urandom chardev has some spinlock.

>#include <pthread.h>
>[...]

Rule of thumb: Post the smallest possible code that shows the problem.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
