Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSDIQpy>; Tue, 9 Apr 2002 12:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSDIQpx>; Tue, 9 Apr 2002 12:45:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11905 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310206AbSDIQpw>; Tue, 9 Apr 2002 12:45:52 -0400
Date: Tue, 9 Apr 2002 12:48:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Mathew, Tisson K" <tisson.k.mathew@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Inserting modules w/o version check
In-Reply-To: <794826DE8867D411BAB8009027AE9EB911C10AE5@FMSMSX38>
Message-ID: <Pine.LNX.3.95.1020409124241.5166A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Mathew, Tisson K wrote:

> All ,
> 
> Can we enforce no version check for modules when they are inserted
> ( insmod

insmod -f module.o
        |_______________ force loading

> ) ? If yes , can this be implemented in the module itself ?
> 

No. `insmod` wouldn't load it so the module doesn't get a chance to
"check" anything.

> Thanks in advance 

Also, note that `struct file_operations` has different member-
locations for different kernel versions. Even if the module
loaded, you might end up with 'read' being 'seek', etc. Bad idea.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

