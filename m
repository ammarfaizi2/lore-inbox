Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285055AbRLQJFN>; Mon, 17 Dec 2001 04:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285058AbRLQJEy>; Mon, 17 Dec 2001 04:04:54 -0500
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:19189
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S285055AbRLQJEk> convert rfc822-to-8bit; Mon, 17 Dec 2001 04:04:40 -0500
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Alexander Viro <viro@math.psu.edu>
cc: Robert Love <rml@tech9.net>,
        =?ISO-8859-1?Q?Ra=FAlN=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is /dev/shm needed? 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Sun, 16 Dec 2001 18:27:33 EST." <Pine.GSO.4.21.0112161825210.937-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 17 Dec 2001 01:03:50 -0800
Message-ID: <13376.1008579830@nova.botz.org>
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> On 16 Dec 2001, Robert Love wrote:
> > have lots of memory to spare, give it a try.  Mount /tmp or all of /var
> > in tmpfs.
> 
> What?  /var contains things like /var/spool/mail.  I _really_ doubt
> that mailboxes disappearing after reboot will make anyone happy.

The original impetus for separating /var from /usr was not that stuff
in /var is temporary, but that anything that the system has to write
to in the course of normal operation goes there... that was so that
/usr could be a filesystem that was shared by many machines (i.e.
NFS mount for diskless workstations, etc.)  /var is for data that is
"variable" from machine to machine, so that /usr can be "constant".

:j


-- 
Jürgen Botz                       | While differing widely in the various
jurgen@botz.org                   | little bits we know, in our infinite
                                  | ignorance we are all equal. -Karl Popper


