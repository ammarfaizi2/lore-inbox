Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268099AbTCFQV1>; Thu, 6 Mar 2003 11:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268057AbTCFQV1>; Thu, 6 Mar 2003 11:21:27 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:1029 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S268039AbTCFQV0>; Thu, 6 Mar 2003 11:21:26 -0500
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
From: James Bottomley <James.Bottomley@steeleye.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Mike Anderson <andmike@us.ibm.com>, Andries.Brouwer@cwi.nl,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0303060455560.25282-100000@montezuma.mastecende.com>
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
	<20030306064921.GA1425@beaverton.ibm.com>
	<Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
	<20030306083054.GB1503@beaverton.ibm.com>
	<Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com>
	<20030306085506.GB2222@beaverton.ibm.com>
	<Pine.LNX.4.50.0303060354550.25282-100000@montezuma.mastecende.com>
	<20030306091824.GA2577@beaverton.ibm.com> 
	<Pine.LNX.4.50.0303060455560.25282-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Mar 2003 10:31:40 -0600
Message-Id: <1046968304.1746.20.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 03:58, Zwane Mwaikambo wrote:
> On Thu, 6 Mar 2003, Mike Anderson wrote:
> 
> > Would it be possible for you to send me a console output with
> > scsi_logging=1 so that I can narrow down the failure case.
> 
> The following is from 2.5.63-mjb2
> 
> http://function.linuxpower.ca/patches/numaq/dmesg-scsi_logging

This log implies the error handling finished after the BDR.  That looks
like the system doesn't have Mike's latest patch for the logic reversal
problem in scsi_eh_ready_devs, could you check this?

Thanks,

James


