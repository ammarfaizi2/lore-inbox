Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVHJOVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVHJOVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVHJOVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:21:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:52982 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965125AbVHJOVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:21:12 -0400
Date: Wed, 10 Aug 2005 09:18:49 -0500
From: serue@us.ibm.com
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Janak Desai <janak@us.ibm.com>, viro@parcelfarce.linux.theplanet.co.uk,
       sds@tycho.nsa.gov, linuxram@us.ibm.com, ericvh@gmail.com,
       dwalsh@redhat.com, jmorris@redhat.com, akpm@osdl.org, torvalds@osdl.org,
       gh@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New system call, unshare
Message-ID: <20050810141849.GA5639@serge.austin.ibm.com>
References: <Pine.WNT.4.63.0508080923470.3668@IBM-AIP3070F3AM> <878xz9dgv4.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878xz9dgv4.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Florian Weimer (fw@deneb.enyo.de):
> * Janak Desai:
> 
> > With unshare, namespace setup can be done using PAM session
> > management functions without patching individual commands.
> 
> I don't think it's a good idea to use security-critical code well

Note that this patch is not removing the CAP_SYS_ADMIN requirement,
just allowing the operation to happen outside of clone().  Unlike
domain transitions in selinux, which should be tied to exec() so
as to tie them to known code, I don't see what clone() would provide
in terms of safety which we are losing.

> without its original specification.  Clearly the current situation
> sucks, but this is mainly a lack of PAM functionality, IMHO.

I'm not sure this is to do with PAM functionality, rather than
just its design.  Is there a way of "fixing" pam so that we don't
need unshare()?

thanks,
-serge
