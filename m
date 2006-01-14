Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWANVet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWANVet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWANVet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:34:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18119 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751347AbWANVes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:34:48 -0500
Date: Sat, 14 Jan 2006 22:34:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: state terminology
Message-ID: <Pine.LNX.4.61.0601142234280.23423@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


If this example kernel functions is called, it will generate an oops, kill 
the current process, and subsequent tries to call it will hang the process 
trying to do so.

        static struct semaphore x;
        void f(void) {
            int *p = NULL;
            down(&x);
            *p++;
            up(&x);
        }

Is there a specific term (other than "hang") associated with this 
situation? It's not a "dead-lock", because there is no other process 
(anymore) which could potentially up the semaphore.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
