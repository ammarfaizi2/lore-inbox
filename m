Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWCJAsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWCJAsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJAsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:48:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59561 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752146AbWCJAsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:48:30 -0500
Date: Thu, 9 Mar 2006 19:48:15 -0500
From: Alan Cox <alan@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, alan@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
Message-ID: <20060310004815.GD24904@devserv.devel.redhat.com>
References: <16835.1141936162@warthog.cambridge.redhat.com> <17424.48029.481013.502855@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17424.48029.481013.502855@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 10:34:53AM +1100, Paul Mackerras wrote:
> MMIO accesses are done under a spinlock, and that if your driver is
> missing them then that is a bug.  I don't think it makes sense to say
> that mmiowb is required "on some systems".

Agreed. But if it is missing it may not be a bug. It depends what the lock
actually protects.

