Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285360AbRLSQML>; Wed, 19 Dec 2001 11:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285356AbRLSQLx>; Wed, 19 Dec 2001 11:11:53 -0500
Received: from web12308.mail.yahoo.com ([216.136.173.106]:50693 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285359AbRLSQLk>; Wed, 19 Dec 2001 11:11:40 -0500
Message-ID: <20011219161139.36317.qmail@web12308.mail.yahoo.com>
Date: Wed, 19 Dec 2001 08:11:39 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re:[PATCH] cciss 2.5.0 for 2.5.1-pre11
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
[...]
> Here is a new patch against 2.5.1-pre11:
> http://www.geocities.com/smcameron/cciss_2.5.0_for_2.5.1-pre11.patch.gz

Having played with it some more, I see it is seriously flawed
in the area of SCSI tape support and locking.  I was probably already pushing
my luck a bit trying to make a hybrid scsi+block driver, and now that
there are per-adapter locks rather than one io_request_lock, it's seems 
quite a lot trickier (perhaps even impossible?) to get such a strange 
beast right.

Anyway, the patch seemed to work upon first trying it, but trying this,
once I managed to get my hands on more than 1 tape drive again, 

  tar cvf /dev/st0 /etc > /dev/null & tar cvf /dev/st1 /etc > /dev/null

(with /dev/st[01] mapping to tape drives on a cciss controller of course)
would quickly demonstrate that patch has big problems.  In case anyone is
trying to use that patch for 2.5.x tree, you should stop using it.  I must
apologize for distributing that kind of garbage, I really should have caught
that earlier.  That the quickly moving kernel tree makes extensive 
testing difficult would be my only and insufficient excuse.

-- steve



__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com
