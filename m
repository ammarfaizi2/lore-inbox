Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbTHSTys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTHSTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:54:30 -0400
Received: from zeke.inet.com ([199.171.211.198]:54417 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S261434AbTHSTyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:54:03 -0400
Message-ID: <3F428051.3090207@inet.com>
Date: Tue, 19 Aug 2003 14:53:53 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Pezoa <dpforos@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TOPDIR kernel variable
References: <20030814231959.22781.qmail@web11204.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pezoa wrote:
> Hello Kernel Community !!  :-)
> 
> I'am compiling lirc software, the kernel source is
> needed to make them, but when i attemt to make them it
> fail because the environment variable TOPDIR is not
> set, looking for the origin of the problem, the script
> that fail is "pathdown.sh", one tiny script of the
> kernel, it fails when is trying to assign
> TP=${TOPDIR:). Reading more i found in the Kernel
> Makefile the line 
> 
> TOPDIR := $(shell /bin/pwd)
> 
> that command should solve my problem but if i launch
> them in the console, it give me the following errors
> in the screen ouput:
> 
> bash: shell: command not found
> bash: TOPDIR:=: command not found

Commands in a Makefile are for make, not commands that bash (your shell) 
will understand.  (If I understand what you said above, that is.)

> What is the intention of the environment variable
> TOPDIR and how can i give them a valid value?

If that is in the Makefile, try
make TOPDIR=...

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

