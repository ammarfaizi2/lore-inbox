Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVF3Uep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVF3Uep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVF3UWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:22:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263028AbVF3UBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:01:09 -0400
Date: Thu, 30 Jun 2005 13:00:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: aia21@cam.ac.uk, arjan@infradead.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-Id: <20050630130027.2ea25dfa.akpm@osdl.org>
In-Reply-To: <20050630124622.7c041c0b.akpm@osdl.org>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	<20050630124622.7c041c0b.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  However, a few things:
> 
>  - is there anything in the current implementation of the permission stuff
>    which might tie our hands if it is later reimplemented?  IOW: does the
>    current FUSE user interface in any way lock us into the current FUSE
>    implementation (fuse_allow_task())?
> 
>  - the fuse mount options don't seem to be documented
> 
>  - aren't we going to remove the nfs semi-server feature?
> 
>  - Frank points out that a user can send a sigstop to his own setuid(0)
>    task and he intimates that this could cause DoS problems with FUSE.  More
>    details needed please?
> 
>  - I don't recall seeing an exhaustive investigation of how an
>    unprivileged user could use a FUSE mount to implement DoS attacks against
>    other users or against root.

You say

  "If a sysadmin trusts the users enough, or can ensure through other
   measures, that system processes will never enter non-privileged mounts,
   it can relax the last limitation with a "user_allow_other" config
   option.  If this config option is set, the mounting user can add the
   "allow_other" mount option which disables the check for other users'
   processes."

What config option, where?

