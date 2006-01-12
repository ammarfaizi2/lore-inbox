Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWALRX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWALRX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWALRX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:23:26 -0500
Received: from silver.veritas.com ([143.127.12.111]:43115 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932315AbWALRXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:23:24 -0500
Date: Thu, 12 Jan 2006 17:23:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kurt Wall <kwall@kurtwerks.com>
cc: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: OT: fork(): parent or child should run first?
In-Reply-To: <20060112013858.GB6178@kurtwerks.com>
Message-ID: <Pine.LNX.4.61.0601121719550.9759@goblin.wat.veritas.com>
References: <20060111123745.GB30219@lgb.hu> <1136983910.2929.39.camel@laptopd505.fenrus.org>
 <20060111130255.GC30219@lgb.hu> <20060112013858.GB6178@kurtwerks.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1392799392-1137086628=:9759"
X-OriginalArrivalTime: 12 Jan 2006 17:23:23.0790 (UTC) FILETIME=[E438C2E0:01C6179C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1392799392-1137086628=:9759
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jan 2006, Kurt Wall wrote:
> On Wed, Jan 11, 2006 at 02:02:55PM +0100, G=C3=A1bor L=C3=A9n=C3=A1rt too=
k 0 lines to write:
> >=20
> > Ok, you're absolutly right here. My problem is to find some solution an=
d not
> > to change the behaviour of fork() of course :) It's quite annoying to
> > introduce some kind of IPC between parent and childs just for transferr=
ing a
> > single pid_t ;-) Using exit status would be great (I would transfer "n"=
)
>=20
> But IPC, especially shared memory, would be great for this if you can
> set up the shmid ahead of time. It would certainly be fast.

I've not been following the thread, but if your suggestion is good, then
better would be to use mmap MAP_SHARED|MAP_ANONYMOUS - that gives memory
shared between parent and children, without all the nuisance of shmids.

Hugh
--8323584-1392799392-1137086628=:9759--
