Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265131AbUFVTAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265131AbUFVTAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUFVS5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:57:50 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:35871 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265286AbUFVS44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:56:56 -0400
Date: Tue, 22 Jun 2004 21:08:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] consolidate in kernel configuration
Message-ID: <20040622190851.GA7672@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <200406221557.i5MFv3YN020056@voidhawk.shadowen.org> <20040622183115.GA7345@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622183115.GA7345@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 07:31:15PM +0100, Christoph Hellwig wrote:
> On Tue, Jun 22, 2004 at 04:57:03PM +0100, Andy Whitcroft wrote:
> > It appears that when we enable CONFIG_IKCONFIG and
> > CONFIG_IKCONFIG_PROC that we actually include two different copies of
> > the .config file.  One plain text and one compressed.  The plain
> > text one used when extracting from the binary is also not recovered
> > cleanly.  The patch below removes this duplication using the same
> > compressed version for both purposes.  Hopefully this will also
> > make it more reasonable to default this option to on.
> 
> Should we really compress it inside the kernel image?  If you care
> for space you compress the kernel image anyway.

In this way it is compressed even when the kernel is uncompressed.

	Sam
