Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264174AbRFMCEC>; Tue, 12 Jun 2001 22:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264181AbRFMCDx>; Tue, 12 Jun 2001 22:03:53 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:29056 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264174AbRFMCDq>; Tue, 12 Jun 2001 22:03:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: linux-kernel@vger.kernel.org
Subject: Hour long timeout to ssh/telnet/ftp to down host?
Date: Tue, 12 Jun 2001 17:02:57 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01061217025700.02061@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have scripts that ssh into large numbers of boxes, which are sometimes 
down.  The timeout for figuring out the box is down is over an hour.  This is 
just insane.

Telnet and ftp behave similarly, or at least tthey lasted the 5 minutes I was 
willing to wait, anyway.  Basically anything that calls connect().  If the 
box doesn't respond in 15 seconds, I want to give up.

Is this a problem with the kernel or with glibc?  If it's the kernel, I'd 
expect a /proc entry where I can set this, but I can't seem to find one.  Is 
there one?  What would be involved in writing one?

If it's glibc I'm probably better off writing a wrapper to ping the 
destination before trying to connect, or killing the connection after a 
timeout with no traffic.  But both of those are really ugly solutions.

Anybody have any light to shed on the situation?

Rob
