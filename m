Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277123AbRJDEbj>; Thu, 4 Oct 2001 00:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277120AbRJDEbW>; Thu, 4 Oct 2001 00:31:22 -0400
Received: from zok.sgi.com ([204.94.215.101]:61863 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277119AbRJDEbJ>;
	Thu, 4 Oct 2001 00:31:09 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - gameport_{,un}register_port must be static when inline 
In-Reply-To: Your message of "Thu, 04 Oct 2001 14:19:13 +1000."
             <15291.58177.900493.276071@notabene.cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Oct 2001 14:31:29 +1000
Message-ID: <11147.1002169889@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001 14:19:13 +1000 (EST), 
Neil Brown <neilb@cse.unsw.edu.au> wrote:
>Linus,
> 2.4.11-pre2 wont compile with some combinations of sound card drivers
> if CONFIG_INPUT_GAMEPORT is not defined, as every driver than include
> gameport.h causes "gameport_register_port" to be defined as a symbol
> and there is a conflict.
>
> This patch makes the relevant inline functions "static" to avoid this
> problem.

Please don't.  This was fixed in the -ac trees several weeks ago, the
correct fix is to move the input rewrite from -ac to Linus's tree.
That is up to the maintainer, Vojtech Pavlik.

