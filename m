Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135814AbRD2PlF>; Sun, 29 Apr 2001 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135819AbRD2Pkq>; Sun, 29 Apr 2001 11:40:46 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13510 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135814AbRD2Pko>;
	Sun, 29 Apr 2001 11:40:44 -0400
Message-ID: <3AEC35F1.189C72F2@mandrakesoft.com>
Date: Sun, 29 Apr 2001 11:40:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mpakovic@fdn.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: 2.4.4 fork.c changes cause linuxconf to fail
In-Reply-To: <3AEC32D6.EC179FCB@fdn.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Pakovic wrote:
> The changes to kernel/fork.c from 2.4.4-pre1 to 2.4.4-pre3 (and in
> 2.4.4) cause the RedHat 6.2 linuxconf utility to fail with the message
> "broken pipe".  The linuxconf utility will run the first time, but all
> subsequent runs give the "broken pipe" error.  The error message is
> generated as a result of a fflush command in linuxconf.  I can provide
> more information upon request.

This patch is definitely breaking things, but AFAIK the fork.c change
only breaks buggy applications...  Adam would you say that assertion is
correct?

Looking at the fork info in SuS v2[1], it doesn't seem to imply any
execution order...
http://www.opengroup.org/onlinepubs/007908799/xsh/fork.html

	Jeff



-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
