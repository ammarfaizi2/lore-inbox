Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWHPOfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWHPOfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWHPOfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:35:48 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:887 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751182AbWHPOfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:35:48 -0400
Date: Wed, 16 Aug 2006 08:35:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: How to avoid serial port buffer overruns?
In-reply-to: <fa.AByCsBI8k71hMVzCyQVimrLiDU4@ifi.uio.no>
To: Raphael Hertzog <hertzog@debian.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Message-id: <44E32D19.3090405@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7bit
References: <fa.AByCsBI8k71hMVzCyQVimrLiDU4@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Hertzog wrote:
> (Please CC me when replying)
> 
> Hello,
> 
> While using Linux on low-end (semi-embedded) hardware (386 SX 40Mhz, 8Mb
> RAM), I discovered that Linux on that machine would suffer from serial
> port buffer overruns quite easily if I use a baudrate high enough (I start
> loosing bytes at >19200 bauds and I would like to make it reliable up to 
> 115 kbauds). I check if overruns are happening with
> /proc/tty/driver/serial ("oe" field).

What kind of serial port are you using? If it's an unbuffered 8250-type 
port, it will NEVER be reliable at higher baud rates. You want a 16550 
(or better) port.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

