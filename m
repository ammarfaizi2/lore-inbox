Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUHRDjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUHRDjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 23:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267252AbUHRDjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 23:39:19 -0400
Received: from av6.lga.net.sg ([203.92.64.141]:59068 "HELO av6.lga.net.sg")
	by vger.kernel.org with SMTP id S267230AbUHRDi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 23:38:57 -0400
Message-ID: <01C48517.98874380.vanitha@agilis.st.com.sg>
From: Vanitha Ramaswami <vanitha@agilis.st.com.sg>
Reply-To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial Driver for PPP - that runs in Half Duplex Mode
Date: Wed, 18 Aug 2004 11:36:25 -0000
Organization: Agilis Communications
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    Thanks for your mail. Can you let me know what are the other protocols that performs better than PPP ?

Thanks
Vanitha

-----Original Message-----
From:	Alan Cox [SMTP:alan@lxorguk.ukuu.org.uk]
Sent:	Tuesday, August 17, 2004 10:12 PM
To:	vanitha@agilis.st.com.sg
Cc:	'linux-kernel@vger.kernel.org'
Subject:	Re: Serial Driver for PPP - that runs in Half Duplex Mode

On Maw, 2004-08-17 at 11:56, Vanitha Ramaswami wrote:
> Do you have a serial port PPP Driver that supports half-duplex mode of 
> operation ?. i.e.  I need RTS to be active when you are transmitting data 
> and to be inactive to receive.

You can do this with a user space helper if performance isnt critical
(ie its not megabits). Create a tty/pty pair. Plug pppd one side of it
and run your own program the other side between it and the real tty.

This is how the old scarabd radio driver worked, although not using PPP
because we found that with the losses we got on radio other protocols
worked better.


