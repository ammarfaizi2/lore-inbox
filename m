Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVIQGjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVIQGjc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVIQGjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:39:32 -0400
Received: from web8505.mail.in.yahoo.com ([202.43.219.167]:10407 "HELO
	web8505.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1750966AbVIQGjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:39:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BYC7Ua+qk5lNYx9Zy0R57eHBz98qkl0p9Tw6Mp06ZrmR4RW4SixgnoSB15bHlYMCEPq78evvVuB6Z/tAvgTXARpp66RlSZP6kM181fw4DQZbzmCH0NGT2zQmew+0FKhd8jBI4NhX10dC+8vvQvlmfA4+uFaZy4eeAtIbhT5rqxM=  ;
Message-ID: <20050917063910.36222.qmail@web8505.mail.in.yahoo.com>
Date: Sat, 17 Sep 2005 07:39:09 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: kernel 2.6 hangs 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a driver module in kernel 2.6. I use ioctl to
drive my module from user application. My driver
module does the following:

When it is called (via ioctl from user application) it
loops in a for loop at most 50 times. After each
iteration i have used delay as below:

wait_queue_head_t wq;
init_waitqueue_head (&wq);

for (/* at most 50 times */) {
   wait_event_timeout(wq, 0, HZ * 2);
/* wait_event_interruptible_timeout(wq, 0, HZ * 2); */
}

But this wait_event_timeout() causes my module to get
hanged when this function is executed! I am saying
that this function causes to get hanged because if I
comment out this function then 'for' loop can iterate
50 times. When this function is being used after first
iteration my module (and as well as well computer)
gets hanged. 

Could you please tell me what is wrong here or what I
need to do?

Regards,
Mano




Manomugdha Biswas


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
