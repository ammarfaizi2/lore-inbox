Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbTJPRIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTJPRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:08:44 -0400
Received: from tolkor.SGI.COM ([198.149.18.6]:36584 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262757AbTJPRIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:08:43 -0400
Message-ID: <3F8ECA11.C4281A8C@sgi.com>
Date: Thu, 16 Oct 2003 11:40:49 -0500
From: Colin Ngam <cngam@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.79C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: Christoph Hellwig <hch@infradead.org>, Patrick Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] Altix I/O code cleanup
References: <3F872984.7877D382@sgi.com> <20031013095652.A25495@infradead.org>
		<yq0llrmncus.fsf@trained-monkey.org>
		<20031015135558.A8963@infradead.org> <yq0brshwcrx.fsf@trained-monkey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:

> >>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
>
> >>  ASSERT_ALWAYS checks it, it may not be pretty but it does check
> >> it.
>
> Christoph> No, it's useless.  It's not different at all from just
> Christoph> derefencing a NULL pointer - both get you an oops.

Hi Christoph,

In the pointer case yes.

>
>
> I haven't looked at the place right there, however if the intention is
> to panic() on a failed kmalloc because the data structure is required
> for a core service, then doing ASSERT_ALWAYS isn't that unreasonable.

ASSERT_ALWAYS is used for many other cases other than just for
testing NULL Pointers.  Whether you call ASSERT_ALWAYS or
call panic with a message or just allow it to oops, a descriptive panic
message can save some time.

Thanks.

colin

>
>
> Jes
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

