Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSHQS3f>; Sat, 17 Aug 2002 14:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318114AbSHQS3f>; Sat, 17 Aug 2002 14:29:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9221 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318113AbSHQS3e>; Sat, 17 Aug 2002 14:29:34 -0400
Date: Sat, 17 Aug 2002 11:36:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Gabriel Paubert <paubert@iram.es>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
In-Reply-To: <3D5E9570.2090908@iram.es>
Message-ID: <Pine.LNX.4.44.0208171134070.3169-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The gdt descriptor alignment really shouldn't matter, but that bogus GDT 
_size_ thing in the descriptor might do it. 

Right now it's set to be 0x8000, which is not a legal GDT size (it should 
be of the form n*8-1), and is nonsensical anyway (the comment says 2048 
entries, but the fact is, we don't _have_ 2048 entries in there).

		Linus

