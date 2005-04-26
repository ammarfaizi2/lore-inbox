Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVDZWIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVDZWIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVDZWIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:08:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61352 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261808AbVDZWIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:08:09 -0400
In-Reply-To: <Pine.LNX.4.58.0504262031490.3393@be1.lrz>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Bodo Eggert <7eggert@gmx.de>, akpm@osdl.org, Jan Hudec <bulb@ucw.cz>,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Subject: Re: [PATCH] private mounts
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF84C9B1E.2214C52C-ON88256FEF.007799F7-88256FEF.0079B32B@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Tue, 26 Apr 2005 15:07:58 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/26/2005 18:08:05,
	Serialize complete at 04/26/2005 18:08:05
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Just to be clear, then: this idea is fundamentally different from the 
>> mkdir/cd analogy the thread starts with above.
>
>NACK, it's very similar to the cd "$HOME" (or ulimit calls) done by the
>login mechanism,

That's not a NACK.  The cd "$HOME" and ulimit calls done by the login 
process (more precisely, by a shell profile) are quite different from the 
mkdir/cd the thread started with.  Who creates a new directory in his 
shell profile?  I assume the mkdir/cd analogy is a case of a person doing 
a mkdir and cd in a running shell.  (That is indeed analogous to what one 
would like to do with a private mount).

When you said "by the login process or by wrappers like nice," in response 
to my pointing out that setnamespace would need to be a shell builtin 
command, I assumed you were talking about putting it in the code that 
execs the shell as opposed to in the shell profile, thus eliminating the 
need for a shell builtin.

But the important thing is just to recognize, as you say explicitly now, 
that setnamespace has to be shell builtin command for 
setnamespace/mknamespace to be analogous to mkdir/cd.  That was my 
original statement, if somewhat indirect:

>> >> >mknamespace -p users/$UID # (like mkdir -p)
>> >> >setnamespace users/$UID   # (like cd)
>> >>                               ^^^^^^^^
>> >> You realize that 'cd' is a shell command, and has to be, I hope. 
That 
>> >> little fact has thrown a wrench into many of the ideas in this 
thread.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
