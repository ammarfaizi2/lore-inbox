Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTKXWA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTKXWA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:00:26 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:25728 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261298AbTKXWAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:00:22 -0500
Date: Mon, 24 Nov 2003 22:04:36 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311242204.hAOM4aZ1000847@81-2-122-30.bradfords.org.uk>
To: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3FC27019.7010402@myrealbox.com>
References: <fa.hevpbbs.u5q2r6@ifi.uio.no>
 <fa.l1quqni.v405hu@ifi.uio.no>
 <3FC27019.7010402@myrealbox.com>
Subject: Re: hard links create local DoS vulnerability and security problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Andy Lutomirski <luto@myrealbox.com>:
> 
> 
> Valdis.Kletnieks@vt.edu wrote:
> 
> > 
> > In any case, if a user is *MAKING* a program set-UID, it's probably because
> > he *wants* it to run as himself even if others invoke it (otherwise, he
> > could just leave it in ~/bin and be happy).  So this is really a red herring,
> > as it's only a problem if (a) he decides to get rid of the binary, and fails
> > to do so because of hard links he doesn't know about, or (b) he's an idiot
> > programmer and it malfunctions if invoked with an odd argv[0]....
> 
> Right... but non-privileged users _can't_ delete these extra links, even 
> if they notice them from the link count.

They can truncate the file to zero length, though, then delete the
'original' link, making all of the other links point to the zero
length file.

John.
