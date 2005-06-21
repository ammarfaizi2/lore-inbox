Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFUNw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFUNw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFUNwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:52:19 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:51860 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261439AbVFUNv1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:51:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Np/V8+/biH+Zdjj+0Qq/k7CGsSUcwRm5jfqkGV7Drmdb20eWr5ZKMn7DryJQOMFH/1SWPy9TUaMzSHnSQXwTS1zHqcKz8Si4dVU3ZkSvvAYH1TIfmW5D4japvhqKEXrmTKPTWphG9392RFWDXqtSpTrXxhTR2I9pMcNXTb4Pe+4=
Message-ID: <a4e6962a05062106515757849d@mail.gmail.com>
Date: Tue, 21 Jun 2005 08:51:27 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: v9fs (-mm -> 2.6.13 merge status)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> v9fs
> 
>     I'm not sure that this has a sufficiently high
>     usefulness-to-maintenance-cost ratio.
> 
 
I think v9fs/9P has some unique aspects which differentiate it from
the other distributed system protocols integrated into Linux:
a) it presents a unified distributed resource sharing protocol.  It
will be able to distribute devices, file systems, system services, and
application interfaces.
b) it provides non-caching RPC-style access to synthetic file systems
which could be used with in-kernel file systems such as sysfs or with
user-space synthetics such as those provided by FUSE
c) its implementation supports transport independence enabling easy
support for different interconnects (shared memory, Xen device
channels, RDMA, Infiniband, etc.)

v9fs-2.0 has a somewhat limited audience at the moment - but now that
the initial implementation is more or less complete we are working to
build applications on top of it (and provide a better server).  It's
being integrated into cluster projects at LANL and being looked at wrt
virtualization I/O at IBM.  Its our hope that these improvements and
cluster applications will motivate more wide-spread use of the v9fs
module.

     -eric
