Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUAJUO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUAJUO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:14:57 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:51363 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265374AbUAJUOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:14:55 -0500
Subject: Re: time cat /proc/*/statm ?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rl@hellgate.ch, linux-mm@vger.kernel.org, u1_amd64@dslr.net
Content-Type: text/plain
Organization: 
Message-Id: <1073757421.828.25312.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jan 2004 12:57:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:

> Why does top still read /proc/*/statm anyway?
> It's not as if top actually ever used that
> information (the top I looked at at the time,
> that is). I submitted a patch a few months ago
> to remove statm because it is a) broken and
> b) redundant. The message containing detailed
> reasoning should be in the linux-mm archives.

top (from procps-3.1.14 at least) only reads
the /proc/*/statm files when you activate
columns that need the statm data. Those are:

%MEM   Memory usage (RES) 
VIRT   Virtual Image (kb) 
SWAP   Swapped size (kb) 
RES    Resident size (kb) 
CODE   Code size (kb) 
DATA   Data+Stack size (kb) 
SHR    Shared Mem size (kb)
nDRT   Dirty Pages count 

By default, some of those get displayed.
The default includes: VIRT RES SHR %MEM

To get rid of those, type this:
   f  o  q  t  n  enter  W
(the "W" writes out a config file)

In case your top is too old for this, you
can go to http://procps.sf.net/ for a new one.


