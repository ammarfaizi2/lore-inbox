Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312970AbSDOQ36>; Mon, 15 Apr 2002 12:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312971AbSDOQ35>; Mon, 15 Apr 2002 12:29:57 -0400
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:20125 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312970AbSDOQ34>; Mon, 15 Apr 2002 12:29:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>, greg@kroah.com
Subject: Re: 2.5.8 OOPS usb-uhci
Date: Mon, 15 Apr 2002 18:29:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CBABB92.8000307@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16x9MA-0007RS-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 April 2002 1:37 pm, Pierre Rousselet wrote:
> PIII 650 UP. kernel tainted by speedtch.o (usb Speedtouch Alcatel driver).
> OOPS logged in /var/log/messages during shutdown (the 2 oops come
> together). *It is not repeatable*. I haven't catched such oops with
> 2.5.8-pre3.

This speedtouch kernel mode driver has problems with preemption.
Perhaps this is the source of your problem.  This is one reason I moved
to the user space driver, see http://speedtouch.sourceforge.net

Duncan.
