Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLFAjz>; Tue, 5 Dec 2000 19:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLFAjo>; Tue, 5 Dec 2000 19:39:44 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:12039 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129458AbQLFAje>; Tue, 5 Dec 2000 19:39:34 -0500
Date: Tue, 5 Dec 2000 16:08:59 -0800
Message-Id: <200012060008.eB608xd23358@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: "Boerner, Brian" <Brian_Boerner@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aacraid for 2.4.0 revisitied
In-Reply-To: <E9EF680C48EAD311BDF400C04FA07B612D4D77@ntcexc02.ntc.adaptec.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre23 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000 18:40:00 -0500 , Boerner, Brian <Brian_Boerner@adaptec.com> wrote:

> I get another oops. I'm not very efficient at reading these messages. To bad
> the oops-tracing.txt file isn't in a little more detail. It seems you have
> to be quite knowledgeable of the inner workings of the Linux kernel to
> understand them, but I digress.

Something is calling proc_mkdir() with name == NULL. Check your code, 
I suspect it's scsi_register_host() that gets a NULL in tpnt->proc_name.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
