Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTKYMGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 07:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTKYMGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 07:06:01 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:24961 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262386AbTKYMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 07:06:00 -0500
Date: Tue, 25 Nov 2003 12:10:10 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311251210.hAPCAAGo000750@81-2-122-30.bradfords.org.uk>
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
In-Reply-To: <yw1xptfh8lh3.fsf@kth.se>
References: <fa.hevpbbs.u5q2r6@ifi.uio.no>
 <fa.l1quqni.v405hu@ifi.uio.no>
 <3FC27019.7010402@myrealbox.com>
 <200311242204.hAOM4aZ1000847@81-2-122-30.bradfords.org.uk>
 <yw1xptfh8lh3.fsf@kth.se>
Subject: Re: hard links create local DoS vulnerability and security problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=):
> John Bradford <john@grabjohn.com> writes:
> 
> >> Right... but non-privileged users _can't_ delete these extra links, =
> even=20
> >> if they notice them from the link count.
> >
> > They can truncate the file to zero length, though, then delete the
> > 'original' link, making all of the other links point to the zero
> > length file.
> 
> It could be tricky to find those extra links if the original has been
> deleted, of course.

True, but as long as at least one of the links which has been made to
the original file is in a directory you have access to, you can simply
create a new link to the file, truncate it, then delete your newly
created link, so actually deleting the 'original' link is not
necessarily a problem :-).

John.
