Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbRAXQOu>; Wed, 24 Jan 2001 11:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAXQOm>; Wed, 24 Jan 2001 11:14:42 -0500
Received: from slc186.modem.xmission.com ([166.70.9.186]:1552 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129939AbRAXQOb>; Wed, 24 Jan 2001 11:14:31 -0500
To: David Wragg <dpw@doc.ic.ac.uk>
Cc: "Benjamin C.R. LaHaise" <blah@kvack.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: limit on number of kmapped pages
In-Reply-To: <Pine.LNX.3.96.1010123205643.7482A-100000@kanga.kvack.org> <y7r7l3ldzxp.fsf@sytry.doc.ic.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jan 2001 07:27:05 -0700
In-Reply-To: David Wragg's message of "24 Jan 2001 10:09:22 +0000"
Message-ID: <m1n1chdo06.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wragg <dpw@doc.ic.ac.uk> writes:

> I'd still like to know what the basis for the current kmap limit
> setting is.

Mostly at one point kmap_atomic was all there was.  It was only the
difficulty of implementing copy_from_user with kmap_atomic that convinced
people we needed something more.  So actually if we can kmap several
megabyte at once the kmap limit is quite high.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
