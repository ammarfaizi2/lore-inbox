Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWDNPF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWDNPF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 11:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWDNPF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 11:05:28 -0400
Received: from web52915.mail.yahoo.com ([206.190.49.25]:20884 "HELO
	web52915.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964984AbWDNPF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 11:05:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2KdQlB42mDk7x1x8YSp50ZVuCdkrIOQrqD6XpEjV83QL1XLkbBu7XZrbxVUZIrZoIvwvUvlnJZl9g0+8DI3dBdH1MPIylA2xnA2EBZu/Nd0QDIT6XHWxZBKUkB9SWxeWs/jtzJRi5FSVUBokh8hEtWdc6Car3F4kxCmAaL0SVTk=  ;
Message-ID: <20060414150527.21907.qmail@web52915.mail.yahoo.com>
Date: Fri, 14 Apr 2006 16:05:27 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [OOPS] Disconnected USB DVB device from Linux 2.6.16.2
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running Linux 2.6.12.2 on a dual P4 1 GB machine with hyperthreading enabled, and I my kernel
has oopsed when disconnecting my USB DVB adapter. The adapter was not in use at the time. I wasn't
able to capture much of the oops, but it looks like the remote-control thread still had a
work-item oustanding after the device was disconnected:

dvb_use_read_remote_control+0x1d/0xba [dvb_usb]
worker_thread
run_work_queue
dvb_usb_read_remote_control+0x0/0xba [dvb_usb]
worker_thread
worker_thread
default_wake_function
kthread
kthread
kernel_thread_helper

Cheers,
Chris



		
___________________________________________________________ 
Switch an email account to Yahoo! Mail, you could win FIFA World Cup tickets. http://uk.mail.yahoo.com
