Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281848AbRK1BRd>; Tue, 27 Nov 2001 20:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283001AbRK1BRM>; Tue, 27 Nov 2001 20:17:12 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:6822 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281848AbRK1BRH>;
	Tue, 27 Nov 2001 20:17:07 -0500
Message-ID: <3C043B11.2FA17A19@pobox.com>
Date: Tue, 27 Nov 2001 17:17:05 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: heads-up: preempt kernel and tux NO-GO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

I have been looking into the tux2 webserver -
Man, what a thing of beauty. A web benchmark
that sends the load on the web server to 150
when running apache results in a load average
of  maybe 2 when running tux, and much faster
results to boot - anyway, I digress....

I built 2.4.16+low-latency+preempt+tux2, and
started testing it. To my horror, the webserver
died - I checked the logs and found an oops -
(for your edification, I attach it below)

So, I figured, preempt and low latency don't
mix well - I'll just build a kernel with tux and
preempt.

To my horror, the new kernel without the
low latency patch oopsed immediately as
well, as soon as I started an apachebench
run from a remote testing box.

(for you edification, I include this oops also)

I removed the preempt patch and basically
compiled just 2.4.16+tux, and hammered on
it for several hours - rock solid.

So, there is an issue with tux and the preempt
patch - I've got big plans for tux atm, so for
now I will have to do without preempt -

Thanks & Regards,

jjs






