Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269641AbUJAAnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbUJAAnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbUJAAnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:43:11 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:12928 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269641AbUJAAnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:43:02 -0400
Message-ID: <7f800d9f04093017435b303f6e@mail.gmail.com>
Date: Thu, 30 Sep 2004 17:43:00 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: USB (OHCI) not working without pci=routeirq
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409241033.09289.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7f800d9f040923102315e8d400@mail.gmail.com>
	 <200409241033.09289.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply ... 

On Fri, 24 Sep 2004 10:33:09 -0600, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> Can you try this whitespace-damaged patch to see whether you're
> seeing the same issue I was?  If this patch fixes it, please post
> the "lspci -n" output for your USB controller, so we can add a
> quirk for it.

Yes, this patch fixes the problem.
I've submitted a different patch based on the testing results (Email
subject: [PATCH] ohci_hcd: ALi USB M5237 host controller init quirk),
which enables the quirk for my USB controller. That hopefully will
save you some work.

The lspci -n output (for reference) is:
0000:00:02.0 Class 0c03: 10b9:5237 (rev 03)

Which equals:
PCI_VENDOR_ID_AL / PCI_DEVICE_ID_AL_M5237

Thanks,
    Andre Eisenbach
