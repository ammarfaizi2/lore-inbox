Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262274AbSJNXZq>; Mon, 14 Oct 2002 19:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSJNXZq>; Mon, 14 Oct 2002 19:25:46 -0400
Received: from mail1.panix.com ([166.84.1.72]:44507 "EHLO mail1.panix.com")
	by vger.kernel.org with ESMTP id <S262274AbSJNXZo>;
	Mon, 14 Oct 2002 19:25:44 -0400
Date: Mon, 14 Oct 2002 16:31:39 -0700
From: Jeff Lightfoot <jeffml@pobox.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
Message-Id: <20021014163139.6d9a6744.jeffml@pobox.com>
In-Reply-To: <20021014163651.6277986c.skraw@ithnet.com>
References: <15786.15416.668502.225074@notabene.cse.unsw.edu.au>
	<20021013172138.0e394d96.skraw@ithnet.com>
	<15785.64463.490494.526616@notabene.cse.unsw.edu.au>
	<20021014045410.4721c209.skraw@ithnet.com>
	<15786.15416.668502.225074@notabene.cse.unsw.edu.au>
	<20021014163651.6277986c.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: Debian GNU/Linux 3.0;kernel 2.4.17
X-Face: 'u<#Qt^/)qW:&(>J[MA.~}578d+Wz3jc?f>yFwasPspU]Aq]z>~^7mt+~<Qi.>\+mlk.)8F LB,8#1B.a@vkU-P>GO7Jv'!a~5<!1TB{ba1P]/wSF+D2O.slxdmvp\6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002 16:36:51 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> my second try shows all the same result. The exact same setup as
> yesterday night and a second try results again in very low
> performance. To name it: about 11 GB of data took an incredible 13,5
> hours to write to the server over a 100 MBit FDX switch.
> This night I will try to reduce rsize/wsize from the current 8192
> down to 1024 as suggested by Jeff.

Small mistake, reads improved with 1024 but writes dropped
dramatically.  The set of options that work are rsize=1024,wsize=8192

Try those and see how it works.

I'm wondering what changed although I do remember my nfs* packages
changing in Debian (Sid) recently (async, sync now having to be
specified).  Hmmm.

-- 
Jeff Lightfoot    --    jeffml@pobox.com    --    http://thefoots.com/
    "so impressed with all you do ... tried so hard to be like you ...
    flew too high and burnt the wing ... lost my faith in everything"
    -- NIN
