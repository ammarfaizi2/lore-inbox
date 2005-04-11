Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVDKWaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVDKWaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDKW2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:28:45 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:6829 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261969AbVDKWYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:24:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=A0+8lnk6ZQqknb6eobafMstwIkm7zzIaYNfzWA8KEaLygn5Nn2EpSNQnctur69fYZc55HqSUOdCgjqJ8lb2MAiYIVGJq83554fH3GHpAXQrvJHvGQWGZ0XXG/d7VIxXemJwmNXkmML3GDpiOYeF6o/wkFQhC31L05B/FfTi7HNI=
Message-ID: <40f323d005041115241f2e80f2@mail.gmail.com>
Date: Tue, 12 Apr 2005 00:24:08 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.12-rc2-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <419860000.1113252411@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050411012532.58593bc1.akpm@osdl.org> <419860000.1113252411@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2005 10:46 PM, Martin J. Bligh <mbligh@aracnet.com> wrote:
> 
> 
> --On Monday, April 11, 2005 01:25:32 -0700 Andrew Morton <akpm@osdl.org> wrote:
> 
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> >
> >
> > - The anticipatory I/O scheduler has always been fairly useless with SCSI
> >   disks which perform tagged command queueing.  There's a patch here from Jens
> >   which is designed to fix that up by constraining the number of requests
> >   which we'll leave pending in the device.
> >
> >   The depth currently defaults to 1.  Tunable in
> >   /sys/block/hdX/queue/iosched/queue_depth
> >
> >   This patch hasn't been performance tested at all yet.  If you think it is
> >   misbehaving (the usual symptom is processes stuck in D state) then please
> >   report it, then boot with `elevator=cfq' or `elevator=deadline' to work
> >   around it.
> >
> > - More CPU scheduler work.  I hope someone is testing this stuff.
> 
> Trying ... having some build problems that seem to be part test-harness,
> part bugs.
> 
> Meanwhile on PPC64:
> 
> fs/cifs/misc.c: In function `cifs_convertUCSpath':
> fs/cifs/misc.c:546: error: case label does not reduce to an integer constant
> fs/cifs/misc.c:549: error: case label does not reduce to an integer constant
> fs/cifs/misc.c:552: error: case label does not reduce to an integer constant
> fs/cifs/misc.c:561: error: case label does not reduce to an integer constant
> fs/cifs/misc.c:564: error: case label does not reduce to an integer constant
> fs/cifs/misc.c:567: error: case label does not reduce to an integer constant
> make[2]: *** [fs/cifs/misc.o] Error 1
> make[1]: *** [fs/cifs] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
>
See this patch from Steve French:
http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@4259f2138nVCJQt3SmaZowdXd8KB7A
 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
