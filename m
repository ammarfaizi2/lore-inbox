Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCZWV7>; Mon, 26 Mar 2001 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCZWVu>; Mon, 26 Mar 2001 17:21:50 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60033 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129506AbRCZWVh>;
	Mon, 26 Mar 2001 17:21:37 -0500
Message-ID: <3ABFC0C6.44A3B7EA@mandrakesoft.com>
Date: Mon, 26 Mar 2001 17:20:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] Questions about  *_do_scsi & create_proc_entry
In-Reply-To: <Pine.GSO.4.31.0103261400360.2886-100000@elaine24.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Another question is that by inspecting the NULL checker's result, I
> found that *_do_scsi is always used in the following way "SRpnt =
> *_do_scsi(SRPnt, ...)" no matther SRPnt is NULL or not. If SRpnt is not
> NULL, why don't just use
>      *_do_scsi(SRPnt, ...);
> The same thing happens to init_etherdev.

WRT init_etherdev, that's the intended effect, because it's 'dev' arg
might indeed by NULL.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
