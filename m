Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130657AbQKJVO4>; Fri, 10 Nov 2000 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130892AbQKJVOq>; Fri, 10 Nov 2000 16:14:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:7172 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130657AbQKJVOf>; Fri, 10 Nov 2000 16:14:35 -0500
Message-ID: <3A0C6445.A75061F1@timpanogas.org>
Date: Fri, 10 Nov 2000 14:10:29 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: wmaton@ryouko.dgim.crc.ca
CC: Andrea Arcangeli <andrea@suse.de>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  
 /var/spool/mqueue]
In-Reply-To: <Pine.GSO.3.96LJ1.1b7.1001110160719.514B-100000@ryouko.dgim.crc.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"William F. Maton" wrote:
> 
> On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> 
> > Andrea Arcangeli wrote:
> > >
> > > On Fri, Nov 10, 2000 at 03:07:46PM -0500, Richard B. Johnson wrote:
> > > > It isn't a TCP/IP stack problem. It may be a memory problem. Every time
> > > > sendmail spawns a child to send the file data, it crashes.  That's
> > > > why the file never gets sent!
> > >
> > > Sure that could be the case. You should be able to verify the kernel kills the
> > > task with `dmesg`.
> > >
> > > However Jeff said the problem happens over 400K and a 500K attachment shouldn't
> > > really run any machine out of memory, so maybe this wasn't his same problem?
> >
> > I think it is.  So it looks like sendmail is bombing when it attempts to
> > send large files.
> 
> Not to use the 'S-word', but we're receiving/sending biggish attachments
> (7MB-9MB) under Solaris 2.6.  Could sendmail be triggering a linux bug, or
> could something specific to linux be triggering a sendmail bug?

Richard has determined that it's a low memory problem on Linux with
sendmail.  Perhaps it affects Solaris as well, try it in low memory with
a big file.

Jeff


> 
> > Jeff
> 
> wfms
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
