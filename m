Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbQKQWkz>; Fri, 17 Nov 2000 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129411AbQKQWkp>; Fri, 17 Nov 2000 17:40:45 -0500
Received: from hermes.mixx.net ([212.84.196.2]:11780 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129189AbQKQWka>;
	Fri, 17 Nov 2000 17:40:30 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Date: Fri, 17 Nov 2000 23:10:43 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A15ACE3.5BED2CA3@innominate.de>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974499029 3991 10.0.0.90 (17 Nov 2000 22:10:29 GMT)
X-Complaints-To: news@innominate.de
To: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:
> 4) A high reliability internal file system.
> 
> Ext2 + bdflush + kupdated? Not likely.  To quote the Be Filesystems
> book, Ext2 throws safety to the wind to achieve speed. This also ties
> into Linux' convoluted VM system, and is shot in the foot by NFS. We
> would need minimally a journaled filesystem and a clean VM design,
> probably with a unified cache (no separate buffer, directory entry and
> page caches). The Tux2 Phase Trees look to be a good step in the
> direction as well, in terms of FS reliability. The filesystem would have
> to do checksums on every block.

Actually, I was planning on doing on putting in a hack to do something
like that: calculate a checksum after every buffer data update and check
it after write completion, to make sure nothing scribbled in the buffer
in the interim.  This would also pick up some bad memory problems.

> Some type of mirroring/clustering would
> be good. And the ability to grow filesystems online, and replace disks
> online, would be key. If your disks are getting old, you may want to
> pre-emptively replace them with faster, newer, larger ones with more
> MTBF left.

This is all coming, but as you say, it's not quite here yet.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
