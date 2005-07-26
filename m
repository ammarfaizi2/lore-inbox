Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVGZIfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVGZIfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVGZIcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:32:48 -0400
Received: from ns.firmix.at ([62.141.48.66]:47271 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261638AbVGZIbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:31:43 -0400
Subject: Re: xor as a lazy comparison
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Philippe Troin <phil@fifi.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>, Puneet Vyas <vyas.puneet@gmail.com>
In-Reply-To: <Pine.LNX.4.61.0507260804230.26583@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	 <42E4131D.6090605@gmail.com> <1122281833.10780.32.camel@tara.firmix.at>
	 <1122314150.6019.58.camel@localhost.localdomain>
	 <1122318659.1472.14.camel@mindpipe> <87ackaitlj.fsf@ceramic.fifi.org>
	 <1122319117.1472.15.camel@mindpipe>
	 <Pine.LNX.4.61.0507260804230.26583@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 26 Jul 2005 10:30:49 +0200
Message-Id: <1122366649.5540.2.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 08:07 +0200, Jan Engelhardt wrote:
[...]
> To answer for x *= 2 vs x <<= 1:
and x += x

> Use * when you would logically want to do a multiplication,
> << if you're working on a bitfield. It's just for keeping the code clean 
> enough so that others may understand it.
> 
> In the longshot, it does not matter, as gcc will optimize out multiplication 
                                          ^^^ the C compiler
> with powers of two to bitops.

And if the C compiler is not doing this properly, such tunings are
probably in 100%-\eps cases worthless anyway.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

