Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313260AbSDYSp4>; Thu, 25 Apr 2002 14:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSDYSp4>; Thu, 25 Apr 2002 14:45:56 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:35255 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S313260AbSDYSpz>; Thu, 25 Apr 2002 14:45:55 -0400
Message-ID: <3CC8426E.B2DBDCE@nortelnetworks.com>
Date: Thu, 25 Apr 2002 13:52:46 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
Cc: ebuddington@wesleyan.edu,
        Eric Buddington <eric@ma-northadams1b-46.bur.adelphia.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Dissociating process from bin's filesystem
In-Reply-To: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net> <20020425184801.60BDC742@merlin.webofficenow.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> On Wednesday 24 April 2002 10:47 pm, Eric Buddington wrote:
> > Is there any way to dissociate a process from its on-disk binary?
> 
> Sure.  Fire up an instance of ramfs, copy the file there (and its associated
> libraries), chroot and exec the copy on ramfs.  Sort of like initrd in
> reverse. :)

If you're writing the binary in question, you could use mlockall() which ensures
that you won't need to page in bits of the binary from disk.  I don't know if
the filesystem considers this totally dissociated though, but it might be good
enough for what you want.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
