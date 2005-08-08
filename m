Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVHHOmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVHHOmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVHHOmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:42:38 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:25266 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750908AbVHHOmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:42:38 -0400
Date: Mon, 8 Aug 2005 09:41:58 -0500
From: serge@hallyn.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Janak Desai <janak@us.ibm.com>, viro@parcelfarce.linux.theplanet.co.uk,
       sds@tycho.nsa.gov, linuxram@us.ibm.com, ericvh@gmail.com,
       dwalsh@redhat.com, jmorris@redhat.com, akpm@osdl.org, torvalds@osdl.org,
       gh@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] New system call, unshare
Message-ID: <20050808144158.GA18406@vino.hallyn.com>
References: <Pine.WNT.4.63.0508080928480.3668@IBM-AIP3070F3AM> <1123512366.31229.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123512366.31229.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> On Llu, 2005-08-08 at 09:33 -0400, Janak Desai wrote:
> > 
> > [PATCH 1/2] unshare system call: System Call handler function sys_unshare
> 
> 
> Given the complexity of the kernel code involved and the obscurity of
> the functionality why not just do another clone() in userspace to
> unshare the things you want to unshare and then _exit the parent ?

The problem I had when I tried using just clone() was that it's
not possible to have a pam library clone() and have the process
being authenticated end up with the new namespace.  At least not
that I could figure out.  Seemed possible that cloning, exiting the
original thread, and returning from the new thread could work, but
it didn't seem to work when I tried it.

thanks,
-serge
