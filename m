Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSDIRAl>; Tue, 9 Apr 2002 13:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310258AbSDIRAk>; Tue, 9 Apr 2002 13:00:40 -0400
Received: from fmr01.intel.com ([192.55.52.18]:43462 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S310241AbSDIRAj>;
	Tue, 9 Apr 2002 13:00:39 -0400
Message-ID: <794826DE8867D411BAB8009027AE9EB911C10AE8@FMSMSX38>
From: "Mathew, Tisson K" <tisson.k.mathew@intel.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Inserting modules w/o version check
Date: Tue, 9 Apr 2002 10:00:27 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dick

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Tuesday, April 09, 2002 9:48 AM
To: Mathew, Tisson K
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inserting modules w/o version check


On Tue, 9 Apr 2002, Mathew, Tisson K wrote:

> All ,
> 
> Can we enforce no version check for modules when they are inserted ( 
> insmod

insmod -f module.o
        |_______________ force loading

> ) ? If yes , can this be implemented in the module itself ?
> 

No. `insmod` wouldn't load it so the module doesn't get a chance to "check"
anything.

> Thanks in advance

Also, note that `struct file_operations` has different member- locations for
different kernel versions. Even if the module loaded, you might end up with
'read' being 'seek', etc. Bad idea.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.
