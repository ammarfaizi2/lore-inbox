Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTJKINg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 04:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTJKINg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 04:13:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39868 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262873AbTJKINf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 04:13:35 -0400
Date: Sat, 11 Oct 2003 10:04:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gabor MICSKO <gmicsko@szintezis.hu>
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
In-Reply-To: <3F854C13.3010902@freemail.hu>
Message-ID: <Pine.LNX.4.56.0310111002270.4993@earth>
References: <3F77F752.7020404@externet.hu> <Pine.LNX.4.56.0309301655330.9692@localhost.localdomain>
 <3F854C13.3010902@freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003, Boszormenyi Zoltan wrote:

> I tried exec-shield-2.6.0-test6-G3 on 2.6.0-test7 patched with
> http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/cset-20031009_0504.txt.gz
> (up to cset-1.1320), it patched with some fuzz and offset differences.

i've uploaded a clean patch against 2.6.0-test7:

        redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test7-G3

> I got the following exploit differences with libsafe and paxtest:
> 
> libsafe-2.0-16:
> [zozo@catv-50624ad9 exploits]$ ./t6
> This program tries to use scanf() to overflow the buffer.
> If you get a /bin/sh prompt, then the exploit has worked.
> Press any key to continue...
> If you see this statement, it means that the buffer
> overflow never occurred.
> 
> Should I worry about it?

i wouldnt worry about this too much - i think the exploit preparation code
itself crashes sometimes (maybe due to randomization effects). I've seen
it previously too.

	Ingo
