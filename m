Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWDGK3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWDGK3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWDGK3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:29:32 -0400
Received: from sandesha.sasken.com ([164.164.56.19]:19412 "EHLO
	mail3.sasken.com") by vger.kernel.org with ESMTP id S932407AbWDGK3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:29:31 -0400
From: "Sreenivasulu Y" <ysreenu@sasken.com>
Subject: kernel socket select issue
Date: Fri, 7 Apr 2006 15:59:04 +0530
Message-ID: <e15eu7$3t6$1@ncc-t.sasken.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-RFC2646: Format=Flowed; Original
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
X-imss-version: 2.037
X-imss-result: Passed
X-imss-scores: Clean:10.64643 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:3 C:2 M:3 S:3 R:3 (0.5000 0.5000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am trying to create multiple sockets in kernel space and use
'sys_select' call on them for reading data from them whenever it is 
available.

But the problem is  socket structures are returned during creation whereas
sys_selct accepts  a set of socket descriptors ( integers ) as input. Is 
there any
API or macro to convert socket structure to socket desciptor ?

It is easy to use 'select' in user space as socket creation would return a 
socket
descriptor which can be used in either 'select' or 'poll' system calls.

Anyone faced a similar problem? Please suggest on this.
-- 
Regards,
Sreenivasulu Y
Senior software Engineer
Sasken Communication Technologies Limited 



"SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA - SURVEY 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"

                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
