Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbVIZMIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVIZMIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVIZMIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:08:52 -0400
Received: from web51012.mail.yahoo.com ([68.142.224.82]:8534 "HELO
	web51012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751402AbVIZMIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:08:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YmYhpu3W6t3DWtvWPcYOw+Cnmlx4lOrscOZgFqFLk4kDpw+WYNtnlWAdpGDu33aHMwH7SSeaadvxlgoiVdxp0+IW1N8ZhMCZZFBfiQHQ56XXG4VnGMSF27h35pP2SS8XZh9um+RrMD9KGI7zz8HXg4rKZ6KrtCO2Njs6iPnBGPs=  ;
Message-ID: <20050926120850.30349.qmail@web51012.mail.yahoo.com>
Date: Mon, 26 Sep 2005 05:08:50 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

For my EndThesis, in the Niederrhein University of
Applied Sciences, I've almost finished a framework
that generates a .config file based on the target
system.This program should help people to generate a
linux kernel Config without spending a lot of time at
the configuration.

The basic idea of the framework is, that you can
specify in the Kconfig files a script which
auto-detect if the hardware involved in this option is
present or not (the script reply 'y' or 'n'). It's up
to the interface to choose what to do with the answer.

This framework is now in its test stage. It works on
my Acer Laptop(TM291LMI with Pentium M and Radeon
9700). That means, that the framework is functional
but additional scripts have to be written for other
type
of hardware/functionality (far away from completed).

The code of this framework has been splitted into six
patches (to be posted following to this mail):
- conf.c and expr.h
- parser
- makefile
- rules
- kconfigs
- documentation

To try it, just patch a 2.6.13 kernel with the patches
following this
mail and set the scripts as follow: chmod u+rwx
scripts/kconfig/rules/*
Then, just type: 'make autoconfig' or 'make
autochoiceconfig'.

The 'autoconfig' will detect your hardware and
automatically include in the kernel whatever hardware
is detected. The 'autochoiceconfig' will let you
choose to include the feature or not when a hardware
is detected.

Any comments and suggestions are welcome !


Regards
Ahmad Reza Cheraghi





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
