Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRCVSeR>; Thu, 22 Mar 2001 13:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132143AbRCVSeI>; Thu, 22 Mar 2001 13:34:08 -0500
Received: from freesurfmta03.sunrise.ch ([194.230.0.32]:8671 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id <S132140AbRCVSdw>; Thu, 22 Mar 2001 13:33:52 -0500
From: "Christian Bodmer" <cbinsec01@freesurf.ch>
Organization: AntiSpam Inc.
To: Rik van Riel <riel@conectiva.com.br>
Date: Thu, 22 Mar 2001 19:32:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Prevent OOM from killing init
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <3ABA534D.2392.3D7585@localhost>
In-Reply-To: <4605B269DB001E4299157DD1569079D2809930@EXCHANGE03.plaza.ds.adp.com>
In-Reply-To: <Pine.LNX.4.21.0103221329000.21415-100000@imladris.rielhome.conectiva>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't say I understand the whole MM system, however the random killing of 
processes seems like a rather unfortunate solution to the problem. If someone 
has a spare minute, maybe they could explain to me why running out of free 
memory in kswapd results in a deadlock situation.

That aside, would it be an improvement to define another process flag 
(PF_OOMPRESERVE) that would declare a process as undesirable to be killed in an 
OOM situation, so that the user has at least some control over what gets killed 
first or last respectively. Only when select_bad_process() runs out of 
unflagged processes will it then proceed to kill the processes with this new 
flag.

Just an idea, I am pretty sure there's tons of reasons why not to introduce a 
new per process flag.

/Cheers
Chris

