Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVJ0Uoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVJ0Uoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVJ0Uoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:44:39 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:50091 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932234AbVJ0Uoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:44:38 -0400
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
X-Message-Flag: Warning: May contain useful information
References: <1130445194.5416.3.camel@blade>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 27 Oct 2005 13:44:19 -0700
In-Reply-To: <1130445194.5416.3.camel@blade> (Marcel Holtmann's message of
 "Thu, 27 Oct 2005 22:33:14 +0200")
Message-ID: <52mzkuwuzg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 27 Oct 2005 20:44:20.0363 (UTC) FILETIME=[34B10DB0:01C5DB37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Marcel> The BIOS and dmidecode tells me that I have 4 GB of RAM
    Marcel> installed and I don't have any idea where to look for
    Marcel> details. What information do you need to analyze this?

Look at the e820 dump in your kernel bootlog.  I'll bet you'll see a
big chunk of reserved address space.  Do you have any PCI devices like
video cards that use a lot of PCI address space?

I don't know if EM64T systems (or whatever the right term is) have a
way of remapping some RAM above 4 GB so that you can use all your
memory in a case like this.

 - R.
