Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbUKRKXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUKRKXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUKRKWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:22:36 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:44551 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262714AbUKRKNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:13:41 -0500
Date: Thu, 18 Nov 2004 10:13:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, alan@redhat.com
Subject: Re: [patch 3] Xen core patch : runtime VT console disable
Message-ID: <20041118101338.GB20859@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk,
	Christian.Limpach@cl.cam.ac.uk, alan@redhat.com
References: <E1CUZZz-00055l-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUZZz-00055l-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 11:51:14PM +0000, Ian Pratt wrote:
> 
> This patch enables the VT console to be disabled at runtime even if it
> is built into the kernel. arch-xen needs this to avoid trying to
> initialise a VT in virtual machine that doesn't have access to the
> console hardware.

You should only need the conditional initialization - all the runtime
checks couldn't be reached anymore if the device isn't actually registered.

