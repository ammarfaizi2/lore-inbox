Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTKYMSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 07:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKYMSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 07:18:18 -0500
Received: from main.gmane.org ([80.91.224.249]:44931 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262395AbTKYMSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 07:18:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Tue, 25 Nov 2003 13:18:14 +0100
Message-ID: <yw1xllq4d4l5.fsf@kth.se>
References: <fa.hevpbbs.u5q2r6@ifi.uio.no> <fa.l1quqni.v405hu@ifi.uio.no>
 <3FC27019.7010402@myrealbox.com>
 <200311242204.hAOM4aZ1000847@81-2-122-30.bradfords.org.uk>
 <yw1xptfh8lh3.fsf@kth.se>
 <200311251210.hAPCAAGo000750@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:5I1+VFqPHyxkZHkXARDAXk92ork=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

>> > They can truncate the file to zero length, though, then delete the
>> > 'original' link, making all of the other links point to the zero
>> > length file.
>> 
>> It could be tricky to find those extra links if the original has been
>> deleted, of course.
>
> True, but as long as at least one of the links which has been made to
> the original file is in a directory you have access to, you can simply
> create a new link to the file, truncate it, then delete your newly
> created link, so actually deleting the 'original' link is not
> necessarily a problem :-).

There's no need to make a new link, since any links will be owned by
the original owner.  That was the concern in the first place.  The
problem is finding a link after the file has been deleted.  It could
be hidden away somewhere in a directory you don't have read or execute
permission for.

-- 
Måns Rullgård
mru@kth.se

