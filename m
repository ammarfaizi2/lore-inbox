Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbUJWOnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUJWOnO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUJWOnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:43:12 -0400
Received: from mail.tmr.com ([216.238.38.203]:28179 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261212AbUJWOml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:42:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.9-ac3
Date: Sat, 23 Oct 2004 10:54:25 -0400
Organization: TMR Associates, Inc
Message-ID: <417A70A1.4040101@tmr.com>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098542071 25167 192.168.12.10 (23 Oct 2004 14:34:31 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Luc Saillard <luc@saillard.org>
To: Luca Risolia <luca.risolia@studio.unibo.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
In-Reply-To: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Risolia wrote:
>>o       Restore PWC driver                              (Luc Saillard)
> 
> 
> This driver does decompression in kernel space, which is not
> allowed. That part has to be removed from the driver before
> asking for the inclusion in the mainline kernel.

What do you mean by "not allowed?" Clearly it would nice if it were in 
user space, but it would have to be in EVERY user application to be 
useful. We have compression in kernel for ppp, and there's only one 
significant use for that, requiring that every application support every 
vendor hardware makes it a non-scalable NxM problem.

The ideal solution would be to convert vendor format to neutral format 
ala netpbm, and then let the applications handle that format (or a small 
set of formats). It sounds as if this driver is essentially doing that.

This is not hardware which virtually every system includes, so size is 
not a big issue here. I think that CPU hogging is a valid concern, 
perhaps that would be a good thing to address rather than taking the 
"wait a few years for support" approach.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
