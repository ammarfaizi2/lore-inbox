Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269380AbUJFVUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269380AbUJFVUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269467AbUJFUq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:46:28 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:7077 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269499AbUJFUor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:44:47 -0400
Message-ID: <009f01c4abed$c0833680$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>, <hzhong@cisco.com>
Cc: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Joris van Rantwijk'" <joris@eljakim.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <003701c4abde$fb251f60$b83147ab@amer.cisco.com> <4164514F.2040006@nortelnetworks.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 6 Oct 2004 22:45:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chris Friesen" <cfriesen@nortelnetworks.com>
Sent: Wednesday, October 06, 2004 21:10
[...]
>  From what Andries posted, we can't block.  If select says its readable, we can 
> "return data, an  end-of-file  indication,  or  an  error other than one 
> indicating that it is  blocked".
> 
> We have no data, network sockets don't have end-of-file indication (or would 
> returning a length of zero count?), and there is no other suitable errno that I saw.

The current behavious is definately not POSIX compliant; returning an error
is better in any case and that error does not necessarily have to be listed in the
ERRORS section of the recvmsg() function description in the standard.
Returning EIO would be an option and is listed as with the errors in POSIX.

--ms


