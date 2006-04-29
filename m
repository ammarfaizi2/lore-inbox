Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWD2IAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWD2IAT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbWD2IAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:00:19 -0400
Received: from ozlabs.org ([203.10.76.45]:39825 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751851AbWD2IAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:00:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17491.7435.783197.658219@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 18:00:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: powerpc/pseries: Print PCI slot location code on failure
In-Reply-To: <20060428224218.GE22621@austin.ibm.com>
References: <20060428224218.GE22621@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> +		location = (char *) get_property(event->dn, "ibm,loc-code", NULL);
> +		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
> +		                "for location=%s pci addr=%s\n",
> +		        location, pci_name(event->dev));

If location is NULL, printk will fortunately save us from a null
pointer dereference; still, it might be nice to have the message say
"location=unknown" or something rather than "location=<NULL>".

Paul.
