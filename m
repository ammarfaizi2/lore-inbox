Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276294AbRI1URx>; Fri, 28 Sep 2001 16:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276288AbRI1URc>; Fri, 28 Sep 2001 16:17:32 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:40872 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S276290AbRI1URW>; Fri, 28 Sep 2001 16:17:22 -0400
Message-ID: <3BB4DAEC.6A64B0E5@bigfoot.com>
Date: Fri, 28 Sep 2001 13:17:48 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Bobby Hitt <bobhitt@bscnet.com>
Subject: Re: 2GB File limitation
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is someone working on a way to overcome the 2GB file limitation in Linux? I
> currently backup several servers using a dedicated hard drive for the
> backups. Recently I saw one backup die saying the the file size had been
> exceeded. I've never had good luck with tape backups, yes they backup, but
> whenever I really need a file, it can't be retrieved.

I use the -B flag to insure the archives are just under 2GB.  This
generates multiple volumes by appending a sequence number if necessary.

For example, on a /home dump of >2GB, the commands

ddate=`date +%m%d%y-%H%M%S`
dump -0uM -b 32 -B 2097142 -f /mnt/home.$ddate.L0.dump -L "abit:/home"
/home

generate

/mnt/home.092801-130439.L0.dump001
/mnt/home.092801-130439.L0.dump002

each guaranteed to be 10K under 2GB.  Fixes potential portability issues
also.

rgds,
tim.
--
