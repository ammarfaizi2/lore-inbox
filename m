Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUCWKtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUCWKtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:49:35 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:64434 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262454AbUCWKt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:49:28 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: synchronous serial port communication (16550A)
Date: Tue, 23 Mar 2004 10:49:26 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c3p4nm$a8m$1@news.cistron.nl>
References: <40600CDD.5050807@pop2wap.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1080038966 10518 62.216.29.200 (23 Mar 2004 10:49:26 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <40600CDD.5050807@pop2wap.net>,
Christof  <mail@pop2wap.net> wrote:
>I have a possible problem with the 8250 serial port driver in linux (2.6.2).
>I communicate with a graphic controller with LCD-Display via ttyS0. This
>controller has a small buffer: 20 bytes. When the buffer is full it
>asserts the CTS line. When it can receive data again, the CTS line is
>cleared.
>My software checks the CTS line each time before sending a byte. If it
>is asserted, it waits until its cleared and goes on. When data is sent
>although CTS is asserted, the graphic controller will be confused and
>garbage will appear on the LCD screen.

Why don't you simply turn on hardware flow control (i.e. enable
CRTSCTS with tcsetattr() or even stty) ?

Mike.
-- 
Netu, v qba'g yvxr gur cynvagrkg :)

