Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314441AbSDRTyC>; Thu, 18 Apr 2002 15:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314442AbSDRTyB>; Thu, 18 Apr 2002 15:54:01 -0400
Received: from codepoet.org ([166.70.14.212]:62637 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314441AbSDRTyA>;
	Thu, 18 Apr 2002 15:54:00 -0400
Date: Thu, 18 Apr 2002 13:53:46 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Message-ID: <20020418195345.GA1309@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020418192728.GA1891@werewolf.able.es> <Pine.LNX.4.10.10204181232090.17538-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 18, 2002 at 12:34:29PM -0700, Andre Hedrick wrote:
> 
> Thanks for the positive feedback!

FYI, I have tried it as well (ide-2.4.19-p6.all.convert.3a.patch
on 2.4.19-p7 plus your recommended #if 0 change) and it has been
working nicely for me as well on a number of machines.  This
certainly seems to be a nice improvement.

> About to add and test HPT372 final and then complete the MMIO operations.
> Next will be to make the driver do the error recovery path that block does

Can you go into a little detail on your plans for error handling?

I think the currently error handling for the ide-subsystem,
especially in the presence of sequences of bad sectors, is not
especially robust (and is quite slow)...  In one case I tested
yesterday (with 2.4.19-p7 plus your patch) using a 340 MB
microdrive with a big chunk of bad sectors on it (the device
admittedly is in pretty sorry shape but makes an excellent
ide-subsystem tester ;-), the kernel wedged solid while trying to
read from it...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
