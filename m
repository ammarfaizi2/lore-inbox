Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbULVCuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbULVCuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbULVCuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:50:35 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:14046 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261891AbULVCua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:50:30 -0500
References: <200412211850_MC3-1-916E-59A6@compuserve.com>
Message-ID: <cone.1103683744.183465.28853.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Ross <chris@tebibyte.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.9-ac16
Date: Wed, 22 Dec 2004 13:49:04 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert writes:

> Chuck Ebbert wrote:
> 
>>  I backported this patch to 2.6.9 but haven't tested it yet.  It requires the
>> 'spurious oomkill' patch I posted earlier in this thread.  Early reports
>> are that it stops the freezes during heavy paging.
> 
>  OK here's one that actually compiles.  (3AM was not a good time to be
> making patches.)

Given that the sysctl is not there in 2.6.9 there is no point exporting the 
variable only to ignore it. You only need this one liner:

>  {
>         int referenced = 0;
>  
> +       ignore_token = 1;

Cheers,
Con

