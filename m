Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTJPNIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTJPNIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:08:43 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:44518 "EHLO jaguar")
	by vger.kernel.org with ESMTP id S262673AbTJPNIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:08:42 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] Altix I/O code cleanup
References: <3F872984.7877D382@sgi.com> <20031013095652.A25495@infradead.org>
	<yq0llrmncus.fsf@trained-monkey.org>
	<20031015135558.A8963@infradead.org>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 16 Oct 2003 09:08:34 -0400
In-Reply-To: <20031015135558.A8963@infradead.org>
Message-ID: <yq0brshwcrx.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

>>  ASSERT_ALWAYS checks it, it may not be pretty but it does check
>> it.

Christoph> No, it's useless.  It's not different at all from just
Christoph> derefencing a NULL pointer - both get you an oops.

I haven't looked at the place right there, however if the intention is
to panic() on a failed kmalloc because the data structure is required
for a core service, then doing ASSERT_ALWAYS isn't that unreasonable.

Jes
