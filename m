Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbUCBV46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUCBV45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:56:57 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:19592 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261873AbUCBV44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:56:56 -0500
Date: Tue, 2 Mar 2004 21:55:54 +0000
From: Dave Jones <davej@redhat.com>
To: Davi Leal <davi@leals.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.2, AMD kernel: MCE: The hardware reports a non fatal, correctable incident
Message-ID: <20040302215554.GA29752@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Davi Leal <davi@leals.com>,
	linux-kernel@vger.kernel.org
References: <200403021900.16085.davi@leals.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403021900.16085.davi@leals.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 07:00:16PM +0100, Davi Leal wrote:
 > What about this message?. Note that the system works. I have not had to 
 > reboot. What meens the below message?.
 > 

The original plan behind that option was to find hardware faults early,
but it seems to trigger a lot of false positives for various reasons.
Part of this problem is that MCEs can also be generated on some hardware
by doing something silly like reading from a reserved part of your
motherboard chipset..

There are also CPU errata that can cause them to falsely trigger in
some unusual cases, but I've not had time to go through the various
errata datasheets to blacklist affected CPUs unfortunatly.

I'm toying with the idea of marking it CONFIG_BROKEN for 2.6,
and fixing it up later.

		Dave

