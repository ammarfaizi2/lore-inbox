Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269566AbUJFVLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269566AbUJFVLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUJFVJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:09:29 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:31653 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269540AbUJFVIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:08:04 -0400
Message-ID: <00f201c4abf1$0444c3e0$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Joris van Rantwijk" <joris@eljakim.nl>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <1097080873.29204.57.camel@localhost.localdomain> <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl> <20041006193053.GC4523@pclin040.win.tue.nl> <1097090625.29707.9.camel@localhost.localdomain>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 6 Oct 2004 23:08:31 +0100
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

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sent: Wednesday, October 06, 2004 20:23
> On Mer, 2004-10-06 at 20:30, Andries Brouwer wrote:
> >        A  descriptor shall be considered ready for reading when a
> >        call to an input function with O_NONBLOCK clear would  not
> >        block,  whether  or  not  the function would transfer data
> >        successfully. (The function might return data, an  end-of-
> >        file  indication,  or  an  error other than one indicating
> >        that it is  blocked,  and  in  each  of  these  cases  the
> >        descriptor shall be considered ready for reading.)
> > 
> > As far as I can interpret these sentences, Linux does not conform.
> 
> Nor does anything else in that case. I guess we need a POSIX_ME_HARDER
> socket option.

The default should be a POSIX compliant socket IMHO; a POSIX_ME_NOT
option could provide better performance.

--ms


