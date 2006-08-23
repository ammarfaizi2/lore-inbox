Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWHWOOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWHWOOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWHWOOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:14:11 -0400
Received: from pat.uio.no ([129.240.10.4]:64954 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964892AbWHWOOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:14:10 -0400
Subject: Re: Group limit for NFS exported file systems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@suse.de>
Cc: Robert Szentmihalyi <robert.szentmihalyi@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <p73u043656n.fsf@verdi.suse.de>
References: <20060823091652.235230@gmx.net>  <p73u043656n.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 10:13:57 -0400
Message-Id: <1156342438.10481.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.769, required 12,
	autolearn=disabled, AWL 0.72, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 13:51 +0200, Andi Kleen wrote:
> "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de> writes:
> 
> > is there a group limit for NFS exported file systems in recent kernels?
> > One if my users cannot access directories that belong to a group he actually _is_ a member of. That, however, is true only when accessing them over NFS. On the local file system, everything is fine. UIDs and GIDs are the same on client and server, so that cannot be the problem. Client and server run Gentoo Linux with kernel 2.6.16 on the server and 2.6.17 on the client.
> 
> NFSv2 has a 8 groups limit in the protocol iirc.

16, and it is a limitation of the RPC protocol's AUTH_UNIX/AUTH_SYS
authentication scheme, rather than being specific to NFS.

Note that if you use KerberosV based authentication at your workplace,
then you can migrate your NFS setup to the stronger RPCSEC_GSS/krb5
authentication. That also happens to fix the 16 groups limit problem.

Cheers,
  Trond

