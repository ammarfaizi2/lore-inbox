Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbTH2NOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbTH2NOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:14:54 -0400
Received: from mx0.gmx.de ([213.165.64.100]:63982 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S261211AbTH2NOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:14:53 -0400
Date: Fri, 29 Aug 2003 15:14:52 +0200 (MEST)
From: Felix Seeger <felix.seeger@gmx.de>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Reiser4 snapshot problems
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005429946@gmx.net
X-Authenticated-IP: [217.80.179.227]
Message-ID: <5222.1062162892@www21.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 August 2003 14:28, you wrote:
> Felix Seeger writes:
>  > Hi
>  >
>  > I am trying out Reiser4 snapshot from August 26th.
>  > I've putted my kde cvs sources on the new partition and compile from
>  > reiser4 now.
>  >
>  > After some time processes hang when accessing this disk. I cannot do
>  > anything on it but I also don't get any errormessage.
>
> If there anything in /var/log/messages, or wherever your kernel log is
> stored?
No, nothing. At least in messages, kern.log and syslog.

But I found the problem. My old dir (on a reiser3 partition) was:
~/download/kde3/cvs which got renamed to old_cvs
My new reiser4 dir is
~/download/kde3/new_cvs

Since there are some full paths (maybe from make) I created a symlink
~/download/kde3/cvs

I removed that link and readded the one to the old partition, all make
processes stopped and I can access the partition again.
Note that I cannot reproduce this if I create just the symlink. That works
fine here, maybe I have to run make again to get the problem back.


>  > Umount, bash autocomletion and things like that don't work. Normal df
>  > and mount are working btw.
>
> Nikita.

have fun
Felix

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

