Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTFCKWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 06:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTFCKWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 06:22:17 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:29063 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264889AbTFCKWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 06:22:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [BENCHMARK] 100Hz v 1000Hz with contest
Date: Tue, 3 Jun 2003 20:36:49 +1000
User-Agent: KMail/1.5.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <XFMail.20030603100038.pochini@shiny.it>
In-Reply-To: <XFMail.20030603100038.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306032036.49790.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003 18:00, Giuliano Pochini wrote:
> On 03-Jun-2003 Con Kolivas wrote:
> > I've attempted to answer the question does 1000Hz hurt responsiveness in
> > 2.5 as much as I've found in 2.4; since subjectively the difference
> > wasn't there in 2.5. Using the same config with preempt enabled here are
> > results from 2.5.70-mm3 set at default 1000Hz and at 100Hz (mm31):
>
> Is there any problem using a frequency other than 100 and 1000Hz ?

Not at all. These were chosen because they were the default 2.4 (100) and 2.5 
(1000) frequencies. The large difference in Hz was postulated to increase the 
in-kernel overhead and the amount of time spent tearing down and building up 
the cpu cache again. 2.4 running at 1000Hz shows poor performance at high 
(>4) loads whereas 2.5 doesn't seem to do this. I originally thought it was 
cache thrashing/trashing responsible. However since 2.5 performance is almost 
comparable at 100/1000 it seems to be that the pure interrupt overhead in 2.5 
is lower?

Con
