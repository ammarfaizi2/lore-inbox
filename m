Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbTAOMfG>; Wed, 15 Jan 2003 07:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbTAOMfF>; Wed, 15 Jan 2003 07:35:05 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:64008 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266316AbTAOMfF>; Wed, 15 Jan 2003 07:35:05 -0500
Message-ID: <3E2557B6.F9421F7C@aitel.hist.no>
Date: Wed, 15 Jan 2003 13:44:38 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.58 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: linux-kernel@vger.kernel.org
Subject: Re: Repeatable scheduling oddity in 2.5.5x? SOLVED
References: <3E2422B5.B5F8AD31@aitel.hist.no> <200301141647.32025.oliver@neukum.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> > Is there anything more I could do to try tracking this down?
> > I have no problems repeating it.
> 
> Could it be that your tasks are blocking on /dev/random ?

Yuck, that was the problem.  I moved /dev/random
out of the way and created a link to urandom, and no more stalls.

Wonder what a conversion utility needs random numbers for at all,
and they surely don't need cryptographically secure ones.

Helge Hafting
