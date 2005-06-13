Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVFMNpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVFMNpV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFMNpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:45:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51416 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261556AbVFMNpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:45:15 -0400
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Horman <nhorman@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050612181006.GC2229@hmsendeavour.rdu.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com>
	 <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk>
	 <20050611193500.GC1097@devserv.devel.redhat.com>
	 <20050612181006.GC2229@hmsendeavour.rdu.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118670162.13250.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 14:42:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-06-12 at 19:10, Neil Horman wrote:
> How about this?  Its the same feature, with an added check in fcntl_dirnotify to
> ensure that only processes with CAP_SYS_ADMIN set can tell processes preforming

Once you are monitoring and sending signals I think its time to ask if
the interface is in totally the wrong place. Would it not be better if
it was part of the ptrace interface to the monitored process ?

