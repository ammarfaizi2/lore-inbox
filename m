Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSGGKLN>; Sun, 7 Jul 2002 06:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSGGKLM>; Sun, 7 Jul 2002 06:11:12 -0400
Received: from codepoet.org ([166.70.99.138]:4255 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314548AbSGGKLL>;
	Sun, 7 Jul 2002 06:11:11 -0400
Date: Sun, 7 Jul 2002 04:13:47 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Christian Robert <xtian-test@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ittle problems with /dev/sr0 with 2.4.19-rc1
Message-ID: <20020707101347.GA21065@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Christian Robert <xtian-test@sympatico.ca>,
	linux-kernel@vger.kernel.org
References: <3D2812F0.C3A4441D@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2812F0.C3A4441D@sympatico.ca>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jul 07, 2002 at 06:07:44AM -0400, Christian Robert wrote:
> [root@X-home:/btemp] # md5sum /dev/sr0
> md5sum: /dev/sr0: Input/output error         <- oups, it failed
> 
> [root@X-home:/btemp] # dd if=/dev/sr0 | md5sum
> dd: reading `/dev/sr0': Input/output error   <- failed here too
> 13440+0 records in
> 13440+0 records out
> 5ec08b6fa7bf09741d1310e5baa800de  -          <- but md5sum is OK

Looks like a read ahead bug to me...  Out of curiousity,
did you use "-no-pad" with mkisofs?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
