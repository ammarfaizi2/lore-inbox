Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRDFRxj>; Fri, 6 Apr 2001 13:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRDFRx2>; Fri, 6 Apr 2001 13:53:28 -0400
Received: from andrew.Triumf.CA ([142.90.106.59]:20494 "EHLO andrew.triumf.ca")
	by vger.kernel.org with ESMTP id <S132281AbRDFRxT>;
	Fri, 6 Apr 2001 13:53:19 -0400
Date: Fri, 6 Apr 2001 10:52:23 -0700 (PDT)
From: Andrew Daviel <andrew@andrew.triumf.ca>
Reply-To: Andrew Daviel <advax@triumf.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: syslog insmod please!
In-Reply-To: <Pine.LNX.4.32.0104060429500.17426-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.30.0104061001490.6216-100000@andrew.triumf.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, various people (Ion, David, James) wrote:
>Recent versions of modutils .. log to .. /var/log/ksymoops
>kmod only works when the user calles for the service ..
>consider unix.o

I'm still using 2.2 kernel where unix.o isn't a module and
/var/log/ksymoops doesn't exist, so I suppose that my original suggestion
would work there, no ?

In the usual game of catchup I guess that if RedHat issued a patch to
insmod for RH6 then indeed insmod would be included in r+ootkits.
Currently lr+k4,5 etc. can be detected by tripwire or my rkdet since they
change ls, ps & netstat, but k+nark can't. I haven't seen it in a r+ootkit
yet but it's only a matter of time.

I presume /var/log/ksymoops is local only (unless you take steps to copy
it remotely) ?

rkdet works on the basis of "I don't care how you got in, but
you mess with /bin/ps and I'll panic the firewall". (of course, if
an intruder finds it running under an identifiable name they can kill it)
I'd like to extend this to LKM based cloaking schemes.
I'd looked at LIDS in the past but don't want to patch the kernel.
Besides, I'm not sure whether LIDS module locking allows lkm to run
to load "good" modules like iso9660 on demand.
Loading modules is OK; I can use an unpredictable name to hide it from
scripts & kids.

Again, is there any way to detect a module such as k+nark if someone has
edited it out of the module list (by moving the "next" pointer) ?


("r*kit" mungled to foil search engines - maybe)
-- 
Andrew Daviel, TRIUMF, Canada
security@triumf.ca

