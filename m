Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTI0SCL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTI0SCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 14:02:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65480 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262123AbTI0SCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 14:02:11 -0400
Date: Sat, 27 Sep 2003 20:02:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Test] exec-shield-2.6.0-test5-G2 vs. paxtest & libsafe
In-Reply-To: <1064678738.3578.8.camel@sunshine>
Message-ID: <Pine.LNX.4.56.0309271950450.21678@localhost.localdomain>
References: <1064678738.3578.8.camel@sunshine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Sep 2003, Gabor MICSKO wrote:

> Kernel:
> Linux sunshine 2.6.0-test5-exec-shield-nptl #3 SMP 2003. sze. 27.,
> szombat, 13.37.42 CEST i686 GNU/Linux

thanks for the testing. The ELF loader changes had a bug which ended up in
creating an extra executable page after .bss, failing some of the tests.  
I've fixed this, could you try the -G3 patch?:

  redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-G3
  redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-bk12-G3

	Ingo
