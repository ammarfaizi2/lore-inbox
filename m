Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129405AbRBAArO>; Wed, 31 Jan 2001 19:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbRBAArE>; Wed, 31 Jan 2001 19:47:04 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:26005 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129173AbRBAAq4>; Wed, 31 Jan 2001 19:46:56 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: modules as drivers and the order of loading
Date: 31 Jan 2001 19:46:47 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3itmvjklk.fsf@shookay.e-steel.com>
In-Reply-To: <ptah7t4do0ts1cukrnqfs38ok1bd2rlnal@4ax.com>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 980988312 7335 192.168.3.43 (1 Feb 2001 00:45:12 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 1 Feb 2001 00:45:12 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@chandlerfamily.org.uk (Alan Chandler) writes:

> As I was building 2.4.1 afresh I took the opportunity to build some of
> the device drivers as modules.  In particular I have a SCSI cdrom
> device (it actually is a cd writer) and I had made that and its
> controller (Adaptec AIC-7xxx driver) modules.
> 
> However, during boot they fail to load because at the time they are
> brought up VFS had not mounted the root filesystem
> 
> I am not sure why they can be built as modules if they then can't be
> loaded?
> 
> OR have I completely misunderstood the approach here.

Well you got it right and wrong at the same time: if you want to use
modules which are used during the boot process, you have to use an initrd
image (which will be loaded before the kernel and stores all your
modules).
-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
