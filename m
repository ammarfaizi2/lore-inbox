Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbUA3WyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 17:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUA3WyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 17:54:13 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:58384 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264363AbUA3WyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 17:54:13 -0500
Date: Fri, 30 Jan 2004 22:53:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org,
       nathans@sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040130225353.A26383@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org, nathans@sgi.com
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040130143459.5eed31f0.akpm@osdl.org>; from akpm@osdl.org on Fri, Jan 30, 2004 at 02:34:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 02:34:59PM -0800, Andrew Morton wrote:
> If two CPUs hit i_size_write() at the same time we have a bug.  That
> function requires that the caller provide external serialisation, via i_sem.

O_APPEND|O_DIRECT writes could do that under XFS..

