Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTDQSKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTDQSKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:10:08 -0400
Received: from bgm-24-94-59-204.stny.rr.com ([24.94.59.204]:48378 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261895AbTDQSKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:10:07 -0400
Date: Thu, 17 Apr 2003 14:21:31 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: Steven Rostedt <rostedt@stny.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: srostedt@goodmis.org
Subject: What's the reason that /dev/mem can't map unreserved RAM?
Message-ID: <Pine.LNX.4.44.0304171414470.13337-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

What's the rational behind /dev/mem not being able to map unreserved RAM?
It can't be for protecting the system, because if you have access to 
reserved RAM (kernel text) then you can modify the remap_pte_range to 
allow for mapping of ram.

I have a user program for debugging kernel modules and the like, and it 
uses /dev/mem to map ram and prints it out. But unless I take out the 
check in remap_pte_range, I can't see allocated pages.

I just want to know the rational behind this.

Thanks,

-- Steve


