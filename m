Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSKNFp4>; Thu, 14 Nov 2002 00:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSKNFpz>; Thu, 14 Nov 2002 00:45:55 -0500
Received: from gremlin.ics.uci.edu ([128.195.1.70]:45776 "EHLO
	gremlin.ics.uci.edu") by vger.kernel.org with ESMTP
	id <S264745AbSKNFpz>; Thu, 14 Nov 2002 00:45:55 -0500
Date: Wed, 13 Nov 2002 21:51:53 -0800 (PST)
From: Mukesh Rajan <mrajan@ics.uci.edu>
To: linux-kernel@vger.kernel.org
Subject: simulating hard disk traces, buffer on/off
Message-ID: <Pine.SOL.4.20.0211132143190.17447-100000@hobbit.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-ICS-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.2, required 5,
	SPAM_PHRASE_00_01, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have the AUSPEX disk traces (collection of timestamped read/write
request) with me and need to simulate them. however because of caching and
read ahead, very less activity ever reaches the disk and does not
correspond to the usage pattern that i am targetting at. 

hence i need to find some mechanism of turning on/off the disk cache. is
there anyway of doing this?

also i would like to collect disk traces before and after the cache
system. for "after cache" i have inserted code in generic_make_request
(ll_rw_blk.c) and seem to get proper traces. however is there any single
point of entry for read/write requests just before they are serviced by
the buffer mechanism where i can insert my trace code for "before
cache" traces i.e. as they are submitted.

please "cc" to me as i'm not on the list.

thanks in advance,
mukesh

