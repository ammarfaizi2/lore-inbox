Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSFMTq7>; Thu, 13 Jun 2002 15:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317810AbSFMTq7>; Thu, 13 Jun 2002 15:46:59 -0400
Received: from N606P028.dipool.highway.telekom.at ([212.183.85.188]:40698 "EHLO
	perception.wg") by vger.kernel.org with ESMTP id <S317809AbSFMTq6>;
	Thu, 13 Jun 2002 15:46:58 -0400
Date: Thu, 13 Jun 2002 21:46:56 +0200
From: "Florian G. Pflug" <fgp@phlo.org>
To: linux-kernel@vger.kernel.org
Subject: More than 32 groups per process
Message-ID: <20020613194656.GB1299@perception.phlo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Since linux currently doesn't support more than 32 groups per process, I
created a patch which expands this limit (65536 at the moment, but this is
quite abitrary).

It replaces the static groups array with a dynamically allocated array
(which is reference counted, so that we don't need to copy it on forking).

The groups array is kept sorted (which is easy, because sys_setgroups always
replaces the whole array), and is searched efficiently by using a binary
search algorithmn.

Since I'm not very experienced in kernel hacking, I'd like to know if
someone has done a similar patch (at least I could then compare my code with
it).

If there is interest, I'll post my patch here - but I didn't want to fill
your inboxes with something most people will find useless (2^16 groups is
quite a lot ;-) ).

greetings, Florian Pflug
