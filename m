Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbTFCMz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbTFCMz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:55:57 -0400
Received: from holomorphy.com ([66.224.33.161]:2982 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264991AbTFCMz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:55:56 -0400
Date: Tue, 3 Jun 2003 06:09:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Giuliano Pochini <pochini@shiny.it>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 100Hz v 1000Hz with contest
Message-ID: <20030603130912.GS8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Giuliano Pochini <pochini@shiny.it>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <XFMail.20030603100038.pochini@shiny.it> <200306032036.49790.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306032036.49790.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003 18:00, Giuliano Pochini wrote:
>> Is there any problem using a frequency other than 100 and 1000Hz ?

On Tue, Jun 03, 2003 at 08:36:49PM +1000, Con Kolivas wrote:
> Not at all. These were chosen because they were the default 2.4 (100) and 2.5 
> (1000) frequencies. The large difference in Hz was postulated to increase the 
> in-kernel overhead and the amount of time spent tearing down and building up 
> the cpu cache again. 2.4 running at 1000Hz shows poor performance at high 
> (>4) loads whereas 2.5 doesn't seem to do this. I originally thought it was 
> cache thrashing/trashing responsible. However since 2.5 performance is almost 
> comparable at 100/1000 it seems to be that the pure interrupt overhead in 2.5 
> is lower?

You could try profiling cache misses etc.

I blame count_active_tasks(). =)


-- wli
