Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265309AbSJaV1v>; Thu, 31 Oct 2002 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSJaV1v>; Thu, 31 Oct 2002 16:27:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:38133 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265309AbSJaV1r>;
	Thu, 31 Oct 2002 16:27:47 -0500
Subject: Re: Proposal for new lock ownership scheme to support NFS over distributed
 filesystems
To: Matthew Wilcox <willy@debian.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       willy@www.linux.org.uk
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF189FE435.22D1CABF-ON87256C63.00761152@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Thu, 31 Oct 2002 13:34:07 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/31/2002 14:34:06
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Sure I can also cc that list.

Regarding your comments I do have a test implementation that takes care of
storing files_struct for local locks so this is not a problem.
(By the way, the use of that field to store that seems very bad idea imho)

Regarding IPv4 not being the only protocol, I would say yes that is a
problem and in fact I the one solution to this would be to enlarge
fl_owner field, but thats a lot of work.

In any case my main problem is to find a unique node identifier that is not
bound to the underlying protocol you are using without requiring
clustering between the nodes that are participating as part of nas head,
suggestions on how to create a clean portable solution are welcome.


Juan



|---------+---------------------------->
|         |           Matthew Wilcox   |
|         |           <willy@debian.org|
|         |           >                |
|         |           Sent by:         |
|         |           <willy@www.linux.|
|         |           org.uk>          |
|         |                            |
|         |                            |
|         |           10/31/02 01:08 PM|
|         |                            |
|---------+---------------------------->
  >------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                  |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                     |
  |       cc:       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org                                      |
  |       Subject:  Re: Proposal for new lock ownership scheme to support NFS over distributed filesystems           |
  |                                                                                                                  |
  |                                                                                                                  |
  >------------------------------------------------------------------------------------------------------------------|




Hey, how about cc'ing either me or linux-fsdevel when discussing file
locking in the future as described in MAINTAINERS?

Your idea doesn't work because we need fl_owner to be the files_struct
for local locks.  It also doesn't work because IPv4 is not the only
protocol which NFS runs over.

--
Revolutions do not require corporate support.



