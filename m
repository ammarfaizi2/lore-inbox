Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276842AbRJHKEH>; Mon, 8 Oct 2001 06:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276844AbRJHKD6>; Mon, 8 Oct 2001 06:03:58 -0400
Received: from pat.uio.no ([129.240.130.16]:24005 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S276841AbRJHKDo>;
	Mon, 8 Oct 2001 06:03:44 -0400
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <m3r8slywp0.fsf@myware.mynet>
	<Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com>
	<20011003232609.A11804@gruyere.muc.suse.de>
	<3BBDAB24.7000909@antefacto.com>
	<20011005150144.A11810@gruyere.muc.suse.de>
	<3BBDB26D.2050705@antefacto.com>
	<20011005163807.A13524@gruyere.muc.suse.de>
	<3BBDCAF8.6070705@antefacto.com>
	<20011005211235.A16163@gruyere.muc.suse.de>
	<3BC16632.4040008@antefacto.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Oct 2001 12:04:04 +0200
In-Reply-To: Padraig Brady's message of "Mon, 08 Oct 2001 09:39:14 +0100"
Message-ID: <shs4rpav46j.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Padraig Brady <padraig@antefacto.com> writes:

     > you then have the same problem with synchronising nanosecond
     > times between the various processors (which could be the other
     > side of a network cable in some

     > configurations)? So perhaps the best solution is to maintain
     > both a generation

     > count which would do for many apps who just care if the file
     > has changed relative

     > to some moment it time and not relative to another file(s) on
     > the filesystem .

     > Then for make type applications you could maintain the full
     > resolution timestamp,

     > however this will still have the
     > synchronisation/portability/CPU expense issues

     > discussed previously.

This `generation count' idea for file change stamping will eventually
have to go into the kernel if only because things like NFSv4 will
require it.

Meanwhile though, you're going have to look elsewhere than ordinary
NFS to be able to share the generation information over your
network. The current protocols support microsecond(v2)/nanosecond(v3)
timestamps only.

Cheers,
   Trond
