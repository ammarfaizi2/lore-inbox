Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVCMNYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVCMNYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVCMNYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:24:45 -0500
Received: from hs-grafik.net ([80.237.205.72]:23816 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S261235AbVCMNYi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:24:38 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: "E.Gryaznova" <grev@namesys.com>
Subject: Re: Fw: 2.6.11-rc5-mm1: reiser4 eating cpu time
Date: Sun, 13 Mar 2005 14:24:33 +0100
User-Agent: KMail/1.7.2
Cc: reiserfs-dev <reiserfs-dev@namesys.com>, linux-kernel@vger.kernel.org
References: <20050303184456.534aedb6.akpm@osdl.org> <4230582F.2050503@namesys.com>
In-Reply-To: <4230582F.2050503@namesys.com>
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503131424.33498@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Well, of course it cannot handle that large files (I wouldn't expect that, 
either). My Problem is that when I open the file, it's not just kwrite but 
other processes that need so much cpu time. That kwrite is eating cpu is ok. 
I cannot reproduce the behaviour for some reason however. 
So for short what's now (2.6.11-mm3) hapening:
I open a file of 150MB with kwrite. Kwrite start using all cpu it can get
After some seconds pdflush kicks in. Kwrite seems to wait, and pdflush is 
eating cpu cyles. These 2 alternate for some time, until file is loaded. 
Please note that this happens when the file is in cache too. No Idea what 
kwrite is doing here, though.
In the case described earlier ent:hda6. was eating my cpu cyles, even after 
kwrite was killed!

regards
Alex

Am Donnerstag, 10. März 2005 15:22 schrieb E.Gryaznova:
> I opened  190Mb textfile with kwrite and tried  to  do  "goto line
> number 1 800 000" (file has about 6 000 000 lines). File is placed not
> on reiser4 but on ext2 partition. And I see that  kwrite eats about
> 90-100% CPU.
> Does kwrite work fine for you on so big files on ext2 filesystem?
>
> I have the following kde version:
> grev@flint:~> kwrite --version
> Qt: 3.2.1
> KDE: 3.1.4
> KWrite: 4.1
>
> Thanks,
> Lena.
>
> >Begin forwarded message:
> >
> >Date: Fri, 4 Mar 2005 02:24:36 +0100
> >From: Alexander Gran <alex@zodiac.dnsalias.org>
> >To: linux-kernel@vger.kernel.org
> >Subject: 2.6.11-rc5-mm1: reiser4 eating cpu time
> >
> >
> >Hi,
> >
> >I have a reiser4 partition on a local IDE disk. I opened a 130MB textfile
> > with kwrite, and killed it while ot opened the file (took to long...)
> > diskio was finished at this point.
> >a [ent:hda6.] Process was eating 100% CPU time for several (54) seconds.
> >Is this a normal, expected behaviour?
> >After trying again, pdflush was eating much cpu time, about the same (50+
> >secs) Note that this happend after reiser4 panic (on an external disk as
> >reported several minutes ago).
> >
> >regards
> >Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
