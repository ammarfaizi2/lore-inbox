Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUBUDXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUBUDXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:23:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31183 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261499AbUBUDV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:21:56 -0500
From: Daniel Phillips <phillips@arcor.de>
To: paulmck@us.ibm.com
Subject: Re: Non-GPL export of invalidate_mmap_range
Date: Fri, 20 Feb 2004 22:19:17 -0500
User-Agent: KMail/1.5.4
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <20040216190927.GA2969@us.ibm.com> <200402201800.12077.phillips@arcor.de> <20040220161738.GF1269@us.ibm.com>
In-Reply-To: <20040220161738.GF1269@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402202158.41140.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 February 2004 11:17, Paul E. McKenney wrote:
> Your earlier patch has a call to invalidate_mmap_range() within
> vmtruncate(), which passes "1" to the last arg, so as to get
> rid of all mappings to the truncated portion of the file.
> So either invalidate_mmap_range() needs to keep the fourth arg
> or needs to be a wrapper for an underlying function that
> vmtruncate() can call, or some such.
>
> The latter may be what you intended to do.

Yes, modulo nobody coming up with a legitimate use for the fourth argument.

Regards,

Daniel

