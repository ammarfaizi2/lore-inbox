Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSGRJ3a>; Thu, 18 Jul 2002 05:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSGRJ3a>; Thu, 18 Jul 2002 05:29:30 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:28679 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317522AbSGRJ33>; Thu, 18 Jul 2002 05:29:29 -0400
Date: Thu, 18 Jul 2002 11:32:26 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020718093226.GC4763@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1026490866.5316.41.camel@thud> <20020716122756.GD4576@merlin.emma.line.org> <20020716124331.GJ7955@tahoe.alcove-fr> <20020716125301.GI4576@merlin.emma.line.org> <ah4ebd$2vc$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4ebd$2vc$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, bill davidsen wrote:

> In article <20020716125301.GI4576@merlin.emma.line.org>,
> Matthias Andree  <matthias.andree@stud.uni-dortmund.de> wrote:
> 
> | dsmc fstat()s the file it is currently reading regularly and retries the
> | dump as the changes, and gives up if it is updated too often. Not sure
> | about the server side, and certainly not a useful option for sequential
> | devices that you directly write on. Looks like a cache for the biggest
> | file is necessary.
> 
> Which doesn't address the issue of data in files A, B and C, with
> indices in X and Y. This only works if you flush and freeze all the
> files at one time, making a perfect backup of one at a time results in
> corruption if the database is busy.

Right, but this would have to be taken up with Tivoli "do snapshot as
dsmc starts, backup from snapshot and discard snapshot on exit"

> My favorite example is usenet news on INN, a bunch of circular spools, a
> linear history with two index files, 30-40k overview files, and all of
> it changing with perhaps 3.5MB/sec data and 20-50/sec index writes. Far
> better done with an application backup!

In that case, when you are restoring from backups, you can also
regenerate index files (at least with tradspool, I never looked at the
"News in Dosen" aggregated spools like CNFS or whatever). It's really
hard if you have .dir/.pag style dbm data bases that don't mirror some
other single-file format.
