Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTEHMJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbTEHMJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:09:02 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:38802 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261369AbTEHMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:08:59 -0400
Message-Id: <200305081220.h48CK9Gi002815@locutus.cmf.nrl.navy.mil>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE he_init_one() 
In-reply-to: Your message of "Thu, 08 May 2003 01:01:46 +0200."
             <20030508010146.A20715@electric-eye.fr.zoreil.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 08 May 2003 08:20:09 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030508010146.A20715@electric-eye.fr.zoreil.com>,Francois Romieu writes:
>- pci_enable_device() isn't balanced on error path;

actually pci_disable_device() should probably go into he_stop() or
add it to he_remove_one() and he_cleanup()
