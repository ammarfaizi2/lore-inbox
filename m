Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSCSTm6>; Tue, 19 Mar 2002 14:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSCSTmu>; Tue, 19 Mar 2002 14:42:50 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:13560 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S292229AbSCSTma>; Tue, 19 Mar 2002 14:42:30 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 19 Mar 2002 08:47:34 -0700
To: John Jasen <jjasen1@umbc.edu>, Mike Galbraith <mikeg@wen-online.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
Message-ID: <20020319154734.GM470@turbolinux.com>
Mail-Followup-To: John Jasen <jjasen1@umbc.edu>,
	Mike Galbraith <mikeg@wen-online.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10203191009290.5694-100000@mikeg.wen-online.de> <Pine.SGI.4.31L.02.0203190915250.7550126-100000@irix2.gl.umbc.edu> <20020319181130.GQ2254@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 19, 2002  10:11 -0800, Mike Fedyk wrote:
> That's not the problem part of the tcpdump output.  The problem is that part
> of an email previously read on the linux box (with no samba runing. (also,
> no smbfs MikeG?)) showed up in the tcpdump output...

I haven't been following the whole thread, but it is _possible_ that the
email data was written to the end of a data block which was later re-used
for a file exported via SMB.  Depending on how the SMB code works, is it
possible that it is sending a whole block of data to the client and/or
not zeroing out new blocks?

Of course (not having looked at the original tcpdump output), is it
possible that the email was captured by tcpdump because it arrived on
the host via the network?

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

