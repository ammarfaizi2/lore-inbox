Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267156AbUBMSBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267158AbUBMSBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:01:00 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:7312 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S267156AbUBMSA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:00:58 -0500
Message-ID: <402D0F6D.7090803@upb.de>
Date: Fri, 13 Feb 2004 18:54:53 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: why are capabilities disabled?
References: <c0iqrq$erh$1@sea.gmane.org> <200402131601.i1DG1Nsl020006@turing-police.cc.vt.edu>
In-Reply-To: <200402131601.i1DG1Nsl020006@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.275,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>"getpcaps 1" shows, that the init-process is started without 
>>cap_setpcap, and i know that i can change that somehow.
>>So why are capabilities disabled? and how do i enable them?

i found the hint again: i have to change the value CAP_INIT_EFF_SET in 
capability.h, so that init-process is not started with disabled 
cap_setpcap, but is this still a security risk?

> There was a long thread back in October 2003 labeled:
> Subject: Re: posix capabilities inheritance
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106673587410831&w=2

everybody's talking about filesystem-capabilities etc.
i still dream of starting a process with a certain capability.
