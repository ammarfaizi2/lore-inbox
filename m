Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281175AbRKTRMH>; Tue, 20 Nov 2001 12:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281177AbRKTRL5>; Tue, 20 Nov 2001 12:11:57 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:31878 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S281175AbRKTRLs>; Tue, 20 Nov 2001 12:11:48 -0500
Message-ID: <3BFA8F87.9FB4C13E@nortelnetworks.com>
Date: Tue, 20 Nov 2001 12:14:47 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.15-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> 
> > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > When a page is deleted for one executable (because we can re-read it from
> > > on-disk binary), it is discarded, not paged out.
> >
> > What happens if the on-disk binary has changed since loading the program?
> > -
> 
> It can't. That's the reason for `install` and other methods of changing
> execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
> The currently open, and possibly mapped file can be re-named, but it
> can't be overwritten.

Actually, with NFS (and probably others) it can.  Suppose I change the file on
the server, and it's swapped out on a client that has it mounted.  When it swaps
back in, it can get the new information.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
