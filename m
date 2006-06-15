Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWFOWoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWFOWoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 18:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWFOWoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 18:44:00 -0400
Received: from ozlabs.org ([203.10.76.45]:27828 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750701AbWFOWn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 18:43:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17553.57932.127038.417630@cargo.ozlabs.ibm.com>
Date: Fri, 16 Jun 2006 08:42:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: powerpc: pseries: Print PCI slot location code on failure
In-Reply-To: <20060615221527.GD12389@austin.ibm.com>
References: <20060615221527.GD12389@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> Resending an older patch (from 28 April) that seems to have fallen
> through the cracks, its not in mailine, is not in -mm and its not
> controversial (its mostly a printk change). Tested.

I don't like doing printk on things that might be NULL (i.e. the
result of get_property).  Even though printk doesn't crash, it would
be nicer for the user to see "location=unknown" or something rather
than "location=<NULL>".

Paul.
