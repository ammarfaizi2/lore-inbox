Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbTD3SHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTD3SHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:07:48 -0400
Received: from pat.uio.no ([129.240.130.16]:26570 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262305AbTD3SHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:07:47 -0400
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: David Howells <dhowells@warthog.cambridge.redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       chas williams <chas@locutus.cmf.nrl.navy.mil>, torvalds@transmeta.com,
       viro@math.psu.edu, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
References: <20030430160239.A8956@infradead.org>
	<27889.1051716620@warthog.warthog>
	<20030430180659.GA29107@delft.aura.cs.cmu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 30 Apr 2003 20:19:32 +0200
In-Reply-To: <20030430180659.GA29107@delft.aura.cs.cmu.edu>
Message-ID: <shshe8fn8zv.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jan Harkes <jaharkes@cs.cmu.edu> writes:

     > On Wed, Apr 30, 2003 at 04:30:20PM +0100, David Howells wrote:
    >> The four calls implemented by Linux are:
    >>
    >> (*) int setpag(void)
    >>
    >> Set Process Authentication Group number. This could easily be
    >> moved into the kernel proper, with the PAG being stored in or
    >> depending from the task structure somehow.
    >>
    >> This would then obviate the need for OpenAFS to mangle the
    >> setgroups and getgroups syscalls.

     > Has been proposed many times in the context of Coda. Perhaps
     > now that there are 2 filesystems in the tree that want
     > something like this we can afford the extra int in the task
     > structure.

Make that 3. We would be able to make good use of the same feature for
strong authentication on NFS.

Cheers,
  Trond
