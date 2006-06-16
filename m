Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWFPDyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWFPDyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWFPDyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:54:47 -0400
Received: from ozlabs.org ([203.10.76.45]:5870 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751014AbWFPDyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:54:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17554.11123.503434.437946@cargo.ozlabs.ibm.com>
Date: Fri, 16 Jun 2006 13:54:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
In-Reply-To: <20060616030432.GA18037@sergelap.austin.ibm.com>
References: <17553.56625.612931.136018@cargo.ozlabs.ibm.com>
	<1150419895.10290.9.camel@localhost.localdomain>
	<20060616030432.GA18037@sergelap.austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn writes:

> So if kernel_thread is really going to be removed, how else should this
> be done?  Just clone?

Who said kernel_thread was going to be removed?  kthread *uses*
kernel_thread.  kthread is a helper to make life easier for drivers,
not a replacement for kernel_thread.

Paul.
