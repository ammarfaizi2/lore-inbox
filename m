Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUHBSpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUHBSpM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUHBSpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:45:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:47028 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261405AbUHBSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:45:08 -0400
Subject: Re: finding out the boot cpu number from userspace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jmoyer@redhat.com, Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <30660000.1091467382@[10.10.2.4]>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
	 <12690000.1091461852@[10.10.2.4]>
	 <16654.29342.977105.723775@segfault.boston.redhat.com>
	 <30660000.1091467382@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091468548.810.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 18:42:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 18:23, Martin J. Bligh wrote:
> Eric went to some lengths to migrate us back to the original boot CPU 
> before kexec'ing. I think this is unnecessary - the new kernel should
> handle booting on any CPU just fine (there was a panic in there at one
> point if the boot CPU didn't match the BIOS's spec'ed one, but I removed
> it).

Several systems have broken SMM or BIOS functionality that requires the
*real* boot processor is used. The panic was correct and should be
restored. See apm_power_off() for one example.


