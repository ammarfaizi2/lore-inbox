Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVCBUdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVCBUdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVCBUdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:33:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:44949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262447AbVCBUci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:32:38 -0500
Date: Wed, 2 Mar 2005 12:31:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
Message-Id: <20050302123123.3d528d05.akpm@osdl.org>
In-Reply-To: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Do you have any objections to merging FUSE in mainline kernel?

I was planning on sending FUSE into Linus in a week or two.  That and
cpusets are the notable features which are 2.6.12 candidates.

- crashdump seems permanently not-quite-ready

- perfctr works fine, but is rather deadlocked because it is
  similar-to-but-different-from ia64's perfmon, and might not be suitable
  for ppc64 (although things have gone quiet on the latter front).

- nfsacl should be OK for 2.6.12 if Trond is OK with it.

- cachefs is a bit stuck because it's a ton of complex code and afs is
  the only user of it.  Wiring it up to NFS would help.

- dm multipath is OK for 2.6.12

- reiser4 is less clear.  Once all the review comments have been addressed
  and we start seeing a bit of vendor pull for it, maybe.

