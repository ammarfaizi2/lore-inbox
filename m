Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263930AbRFWM5u>; Sat, 23 Jun 2001 08:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263931AbRFWM5k>; Sat, 23 Jun 2001 08:57:40 -0400
Received: from cc1033417-a.etntwn1.nj.home.com ([24.180.28.169]:38640 "EHLO
	serve.riede.org") by vger.kernel.org with ESMTP id <S263930AbRFWM5Z>;
	Sat, 23 Jun 2001 08:57:25 -0400
Message-ID: <3B3491F3.A7CB9955@riede.org>
Date: Sat, 23 Jun 2001 08:56:19 -0400
From: Willem Riede <osst@riede.org>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Anil B. Somayaji" <soma@cs.unm.edu>
CC: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: osst & ide-2.2.19 conflict?
In-Reply-To: <ut2lmmjek1t.fsf@lydia.adaptive.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anil B. Somayaji" wrote:
> 
> In the ide.2.2.19.05042001 patch, there is the following bit of code
> in ide-scsi.c, which prevents the ide-scsi driver from allowing access
> to an OnStream DI-30 tape drive.  This is strange, since this same
> drive can be used with the included ide-scsi + osst drivers in the
> stock 2.2.19 kernel.  If you delete this bit, however, ide-scsi
> recognizes the drive, and the osst driver seems to work fine.
> 
> Here's the offending code:
> 
>   #ifndef CONFIG_BLK_DEV_IDETAPE
>    /*
>     * The Onstream DI-30 does not handle clean emulation, yet.
>     */
>    if (strstr(drive->id->model, "OnStream DI-30")) {
>            printk("ide-tape: ide-scsi emulation is not supported for %s.\n", drive->id->model);
>            continue;
>    }
>   #endif /* CONFIG_BLK_DEV_IDETAPE */
> 
> Any reason for this to stay in the ide patch, or is it now obsolete?
> 
It is obsolete, and can safely be removed.

Success. Willem Riede.
