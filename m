Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129813AbQJZVn4>; Thu, 26 Oct 2000 17:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129946AbQJZVns>; Thu, 26 Oct 2000 17:43:48 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:51112 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129813AbQJZVn3>; Thu, 26 Oct 2000 17:43:29 -0400
Date: Thu, 26 Oct 2000 14:48:07 -0700
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Linux's implementation of poll() not scalable?
To: Jim Gettys <jg@pa.dec.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@biederman.org>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <39F8A697.DD9CA433@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <200010261951.MAA18919@pachyderm.pa.dec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gettys wrote:
> So I want an interface in which I can get as many events as possible
> at once, and one in which the events themselves can have appropriate
> aggregation behavior.  It isn't quite clear to me if the proposed interface
> would have this property.

I believe get_event, /dev/poll, and kqueue all share this property.  
e.g. none of them will present multiple POLLIN events per fd per call.  
Is that what you meant?

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
