Return-Path: <linux-kernel-owner+w=401wt.eu-S1751242AbXAUHW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbXAUHW0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 02:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbXAUHW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 02:22:26 -0500
Received: from mx0.karneval.cz ([81.27.192.17]:54515 "EHLO av3.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbXAUHWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 02:22:25 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Sunil Naidu <akula2.shark@gmail.com>
Subject: Re: Realtime-preemption for 2.6.20-rc5 ?
Date: Sun, 21 Jan 2007 00:39:26 +0100
User-Agent: KMail/1.9.4
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701210039.27284.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sunil and Ingo,

Date: 2007-01-20 02:56:40 GMT (20 hours and 26 minutes ago)
> 2007-01-20, Sunil Naidu <akula2.shark@gmail.com> wrote:
> I did refer the same. Is it necessary to use only base kernel, say
> 2.6.19? Or, can I go ahead with 2.6.19 + 2.6.19.2 patch + 2.6.19-rt
> patch?
>
> If yes, any reason why we need to apply rt patch only to a base kernel?

according to my observation 2.6.19-rt15 is based/includes 2.6.19.1 changes.

But there has been that nasty clear_page_dirty_for_io() bug causing
corruption of ext3. Even that I have tested more 2.6.20-rc + rt, I preffer
to stay on "stable" kernel on boxes which I use daily until next stable
appears. I have backported clear_page_dirty_for_io() to 2.6.19-rt15
and it worked fine. I have tried to update 2.6.19-rt15 to 2.6.19.2
base. There is result of my attempt

Unofficial incremental patch from 2.6.19-rt15 to 2.6.19.2 + rt
http://rtime.felk.cvut.cz/repos/ppisa-linux-devel/kernel-patches/current/patch-2.6.19.2-incr.patch

Kernel seems to work correctly. I have checked the patch contents
and I have not noticed any RT problematic changes in the code according
to my dumb knowledge.

I would be very happy, if Ingo would be so kind and could confirm my findings,
because I am not sure, if final 2.6.20+rt would be ready before we need
to prepare setup for our next semester classes at university.

Best wishes

                Pavel Pisa
        e-mail: pisa@cmp.felk.cvut.cz
        www:    http://cmp.felk.cvut.cz/~pisa
        work:   http://www.pikron.com
