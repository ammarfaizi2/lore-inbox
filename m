Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSICPtA>; Tue, 3 Sep 2002 11:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSICPtA>; Tue, 3 Sep 2002 11:49:00 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:2041 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317181AbSICPs7>; Tue, 3 Sep 2002 11:48:59 -0400
Date: Tue, 3 Sep 2002 17:53:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.LNX.4.44L.0209031211400.1519-100000@duckman.distro.conectiva>
Message-ID: <Pine.GSO.3.96.1020903174246.20090C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Rik van Riel wrote:

> > Rationale:
> > No caching means that each kernel doesn't go off with its own idea of
> > what is on the disk in a file, at least. Dunno about directories and
> > metadata.
> 
> And what if they both allocate the same disk block to another
> file, simultaneously ?

 You need a mutex then.  For SCSI devices a reservation is the way to go
-- the RESERVE/RELEASE commands are mandatory for direct-access devices,
so thy should work universally for disks.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

