Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUIJQe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUIJQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUIJQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:32:10 -0400
Received: from hermes.uci.kun.nl ([131.174.93.58]:1438 "EHLO hermes.uci.kun.nl")
	by vger.kernel.org with ESMTP id S267601AbUIJQbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:31:11 -0400
Date: Fri, 10 Sep 2004 18:30:03 +0200
From: Arnout Engelen <arnouten@bzzt.net>
X-Face: .NTzn{Sdm0J?lRrT!!ZlD*F.4iAkyy+A$,QfVsVBz.,k4QFi66b]ykR.Y..HR{OM>4b,9..
 |we.b[Oi![,fv-=7w.oRq>9.HIi$7.P*nSW=3p&*r91H=_h,b.4<C'oSg2eUfHPO8%wVoP^i_TyAZ.
 h0I(cIjB=..hc436%E(QM.Qg[z~|]7.5-X>s.X*caTn}0NY"A.q<+[wb~N2
Subject: truncated lines in /proc/net/tcp
To: linux-kernel@vger.kernel.org
Message-id: <20040910163003.GT11646@bzzt.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed lines in the output of /proc/net/tcp sometimes appear 'truncated', like
this:

  52: 010310AC:9D95 030310AC:1770 06 00000000:00000000 03:0000146C
  00000000     0        0 0 2 c4e3f0c0

(also notice that the inode is '0' instead of some large integer)

This is print by the code at:

  http://lxr.linux.no/source/net/ipv4/tcp_ipv4.c?v=2.6.8.1#L2504

Maybe the value of 'tp' gets invalidated at some point during the
gathering of the data to be printed there?

(note that I'm not myself a kernel developer. I ran into this when
writing a userspace application and decided I wanted to know why this
happened. I saw this behaviour on a 2.4.26 kernel, but the code 
doesn't appear to be significantly different in 2.6. I'm not subscribed 
to the LKML, so if you want to ask me something please CC me personally).

-- 
Arnout Engelen <arnouten@bzzt.net>

  "If it sounds good, it /is/ good."
          -- Duke Ellington
