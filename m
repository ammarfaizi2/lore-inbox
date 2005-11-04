Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVKDHGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVKDHGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVKDHGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:06:33 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:13065 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751412AbVKDHGc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:06:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rzqzUQ6TUV0NQRFBE1cVeeQrQCGNWAIhnWr22uTo+qr5n5A2wVYI+wgUY+exmIs96gJQjMVOKgcHJPSyXs/7RkwayGexhrf3U9KXetD2znayvzvS0FIdoeFkxCqEYBe/isAFI5JCCyPwPLlanMACUQKClPgCpHSDt0rGTnwqq+o=
Message-ID: <569d37b00511032306y27519a8am69f2385fdbd4b81f@mail.gmail.com>
Date: Fri, 4 Nov 2005 02:06:31 -0500
From: Trevor Woerner <twoerner.k@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: latency report
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been performing an investigation to determine the suitability
of using GNU/Linux as a basis for embedded real-time (ish) work and
have prepared a report of my findings. I have made the assumption that
the application logic will be coded as a number of user-space
applications which interact with the hardware. As such, interrupt
latency alone is of little interest; instead I focused more on
measuring the time it takes some data to travel into the target
device, through a bunch of user-space processes (connected via named
FIFOs), then back out the device.

My report currently compares the stock kernel.org 2.6.14 with Ingo's
2.6.14-rt2 patches on two target boards. All preemption settings have
been evaluated. A full explanation of how these tests were conducted,
the various components that were used, the test scenarios that were
created, the results I measured, kernel configurations, and required
patches are included in the report.

This project's index can be found here ("Linux Latency"):
http://geek.vtnet.ca/embedded.html

All of the tools, scripts, and code I wrote to measure and generate
this report can be found in the project tarball (~1.7MB bzip2):
http://geek.vtnet.ca/embedded/LatencyTests/latencytests-3.2.1.tar.bz2

The report is here in html:
http://geek.vtnet.ca/embedded/LatencyTests/html/index.html

Code documentation (in various formats) and a PDF of the report are
also available.

Ingo Molnar has been incredibly helpful and provided an enormous
amount of initial feedback and suggestions; thank you.

Please CC me on any replies.
Thank you.
