Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314598AbSDTJ4I>; Sat, 20 Apr 2002 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314599AbSDTJ4H>; Sat, 20 Apr 2002 05:56:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10508 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314598AbSDTJ4G>; Sat, 20 Apr 2002 05:56:06 -0400
Message-ID: <3CC12C99.5030607@evision-ventures.com>
Date: Sat, 20 Apr 2002 10:53:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Francois Barre <francois.barre@enst-bretagne.fr>
CC: linux-kernel@vger.kernel.org, gadio@netvision.net.il
Subject: Re: PROBLEM: buggy ide-scsi
In-Reply-To: <3CC116CE.5090505@enst-bretagne.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Barre wrote:
>    ide-scsi not working on kernel 2.5.8
> 
> I try to burn cds on a 2.5.8 kernel (debian distrib) using kreatcd (and 
> gtoaster) on a Ricoh Ide Cd Writer using the ide-scsi and a unexpected 
> error occurs. Using the same config, when I boot on a 2.4.17 kernel, 
> there ain't no problem.
> Did you change anything ? The ide-scsi module hasn't been maintained 
> since Jul 4, 1999 (kinds of 2.2.x period, no ?).
> Did configuration change (i tried to turn over, no way...).
> In fact, something worrying me. I use the ide-scsi as a module, and 
> while no cd burner is launched, lsmod tells me it's used (only in 2.5.8 
> kerns, in 2.4.17 it's unused). I wonder if it's not the [scsi_eh_0] 
> kernel thread which tries to use it (what for ?). Maybe this is what 
> blocks the use of ide-scsi...
> I'll try to debug it my way, but it will take ages....
> 
> If you have any clues, tell me.


As a matter of fact there where significant changes to
the way block IO requests get handled in the IDE driver.
(TCQ stuff).
Due to this several (all?) of the drivers different from ide-disk
are now nonfunctional until they get adapted to those
changes. Please be patient, since this is certainly going to take
some time.

