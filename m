Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUJ3WMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUJ3WMB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUJ3WMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:12:00 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12557 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261352AbUJ3WLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:11:42 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Date: Sun, 31 Oct 2004 01:11:07 +0300
User-Agent: KMail/1.5.4
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> <1099170891.1424.1.camel@krustophenia.net>
In-Reply-To: <1099170891.1424.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 00:14, Lee Revell wrote:
> On Sun, 2004-10-31 at 00:00 +0300, Denis Vlasenko wrote:
> > If only glibc / X / KDE / OpenOffice (ugggh) people could hear you more...
> > 
> >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
> > 15364 root      15   0 38008  26M 28496 S     0,0 10,8   0:57   0 kmail
> > 20022 root      16   0 40760  24M 23920 S     0,1 10,0   0:04   0 mozilla-bin
> >  1627 root      14  -1 71064  19M 53192 S <   0,1  7,9   3:16   0 X
> >  1700 root      15   0 25348  16M 23508 S     0,1  6,5   0:46   0 kdeinit
> >  3578 root      15   0 24032  14M 21524 S     0,5  5,8   0:23   0 konsole
> 
> Wow. evolution is now more bloated than kmail.
> 
>  1424 rlrevell  15   0  125m  47m  29m S  7.8 10.1   1:41.78 evolution
>  1508 rlrevell  15   0 92432  30m  29m S  0.0  6.4   0:14.15 mozilla-bin
>  1090 root      16   0 55676  18m  40m S 24.8  3.9   0:46.98 XFree86
>  1379 rlrevell  15   0 33776  16m  18m S  0.3  3.5   0:06.65 nautilus
>  1377 rlrevell  15   0 19392  11m  15m S  0.0  2.5   0:03.29 gnome-panel
>  1458 rlrevell  16   0 28188  11m  15m S  3.9  2.5   0:10.44 gnome-terminal
>  1307 rlrevell  15   0 20828  11m  17m S  0.0  2.4   0:03.08 gnome-settings-

Well, I can try to compile packages with different options
for size, I can link against small libc, but I feel this
does not solve the problem: the code itself is bloated...

I am not a code genius, but want to help.

Hmm probably some bloat-detection tools would be helpful,
like "show me source_lines/object_size ratios of fonctions in
this ELF object file". Those with low ratio are suspects of
excessive inlining etc.

More ideas, anyone?
--
vda

