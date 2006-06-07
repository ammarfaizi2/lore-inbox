Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWFGXCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWFGXCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWFGXCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:02:06 -0400
Received: from havoc.gtf.org ([69.61.125.42]:17822 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932458AbWFGXCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:02:04 -0400
Date: Wed, 7 Jun 2006 19:02:02 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
Message-ID: <20060607230202.GA12210@havoc.gtf.org>
References: <1149694978.12920.14.camel@amdx2.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149694978.12920.14.camel@amdx2.microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:42:58AM -0500, Paul Fulghum wrote:
> Fix build errors caused by generic HDLC
> and synclink configuration mismatch. Generic HDLC
> symbols referenced from synclink drivers do not
> resolve if synclink drivers are built-in and generic
> HDLC is modularized.

Please fix the code instead.  _No_ kernel code should be doing
	#define CONFIG_{xxx}

because that is a reserved namespace.

	Jeff



