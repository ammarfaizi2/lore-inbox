Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286102AbRLIAUF>; Sat, 8 Dec 2001 19:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286103AbRLIATz>; Sat, 8 Dec 2001 19:19:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8205 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286102AbRLIATs>; Sat, 8 Dec 2001 19:19:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: File copy system call proposal
Date: 8 Dec 2001 16:19:26 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9uuame$ssu$1@cesium.transmeta.com>
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu> <9us387$poh$1@cesium.transmeta.com> <1007791439.355.7.camel@quinn.rcn.nmt.edu> <E16Chyk-0000zH-00@starship.berlin>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16Chyk-0000zH-00@starship.berlin>
By author:    Daniel Phillips <phillips@bonn-fries.net>
In newsgroup: linux.dev.kernel
> 
> There's some merit to this idea.  As Peter pointed out, an in-kernel cp isn't 
> needed: mmap+write does the job.  The question is, how to avoid the 
> copy_from_user and double caching of data?
> 

One thing that one could do for an in-kernel copy is to extend
sendfile() to support any kind of file descriptor.  That'd be a very
clean way to do it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
