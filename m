Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTFTDym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 23:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbTFTDym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 23:54:42 -0400
Received: from p0013.as-l043.contactel.cz ([194.108.242.13]:7296 "EHLO
	noodles.netw") by vger.kernel.org with ESMTP id S262223AbTFTDyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 23:54:41 -0400
From: "Jan Spitalnik (Volny)" <spity@volny.cz> (by way of Jan Spitalnik
	(Volny) <spity@volny.cz>)
Subject: What's wrong with console_loglevel?
Date: Fri, 20 Jun 2003 06:08:38 +0200
User-Agent: KMail/1.5.9
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306200608.39139.spity@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 2.5.72, BK pull from today evening.
And there's something rotten as I set console_loglevel
with 'dmesg -n 3' (kernel.h(37): #define KERN_ERR "<3>")
and for example when I do 'modprobe e100' it prints
its banner into console even though I have configure syslog
no to do so. I've checked the log level of those messages
and they use (e100_main.c(685)) KERN_NOTICE, which should
be log level 7. So why does kernel print messages with
lower prio than I had permited? Was there some change
I'm unaware of that somehow changed semantics how this works?
Thanks!

--
Kind regards,
		Jan Spitalnik

There are 10 types of people in the world: Those who understand binary,
and those who don't! :-)
