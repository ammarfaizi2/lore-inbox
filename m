Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277166AbRJDH50>; Thu, 4 Oct 2001 03:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277167AbRJDH5Q>; Thu, 4 Oct 2001 03:57:16 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:16907 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S277166AbRJDH5B>;
	Thu, 4 Oct 2001 03:57:01 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110040750.f947orU470874@saturn.cs.uml.edu>
Subject: Re: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
To: bob@proulx.com (Bob Proulx)
Date: Thu, 4 Oct 2001 03:50:52 -0400 (EDT)
Cc: ebiederm@xmission.com (Eric W. Biederman), ndeb@ece.cmu.edu (Nilmoni Deb),
        jim@meyering.net (Jim Meyering), viro@math.psu.edu,
        bug-fileutils@gnu.org, Remy.Card@linux.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <200110040632.f946WZG02255@torment.proulx.com> from "Bob Proulx" at Oct 04, 2001 12:32:35 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Proulx writes:

> I tested this on both HP-UX, IBM AIX and Linux.  HP-UX always
> preserved the previous timestamps.  The same with 2.2.x versions of
> Linux.  AIX was different and preserved the previous timestamp if
> the .. entry was the same as before but updated the timestamp if .. was
> different than before.  But in the case where no real changes occurred
> none updated the timestamp.  It would be interesting to see what
> Sun's Solaris and other systems do in those cases.  This does not seem
> like a huge deal.  There were differences in the different commercial
> flavors.  But I like to think that we can do better than that.

Compaq Tru64 5    No time change in any case.
