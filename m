Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbREVSZJ>; Tue, 22 May 2001 14:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262710AbREVSYt>; Tue, 22 May 2001 14:24:49 -0400
Received: from draco.macsch.com ([192.73.8.1]:11732 "EHLO draco.macsch.com")
	by vger.kernel.org with ESMTP id <S262706AbREVSYr>;
	Tue, 22 May 2001 14:24:47 -0400
Message-ID: <3B0AAEED.ED8A115F@mscsoftware.com>
Date: Tue, 22 May 2001 11:24:45 -0700
From: "David N. Lombard" <david.lombard@mscsoftware.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-8.msc-up i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] s_maxbytes handling
In-Reply-To: <3B0A7C0F.C824FDB5@uow.edu.au> <E152Dik-00021y-00@the-village.bc.nu> <9ee8qo$jgk$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
[deletia]
> 
> So returning 0 for write() is usually a bad idea - exactly because it
> does not have very well-defined semantics.  So -EFBIG is certainly the
> preferable return value, and seems to be what SuS wants, too.

And what LFS wants too:

2.2.1.27 write() and writev()

DESCRIPTION

     For regular files, no data transfer will occur past the offset
     maximum established in the open file description associated with
     fildes.

ERRORS

     These functions will fail if:

     [EFBIG]
          The file is a regular file, nbyte is greater than 0 and the
          starting position is greater than or equal to the offset
          maximum established in the open file description associated
          with fildes.

     Note: This is an additional EFBIG error condition.

-- 
David N. Lombard
