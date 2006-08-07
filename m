Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWHGNm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWHGNm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWHGNm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:42:28 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:50962 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750949AbWHGNm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:42:27 -0400
Message-ID: <44D742DD.6090004@shadowen.org>
Date: Mon, 07 Aug 2006 14:40:45 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: x86_64 command line truncated
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the command line on x86_64 is being truncated during boot:

Bootdata ok (command line is root=/dev/sda1 ro profile=2 console=tty0 
console=ttyS0,57600 autobench_args: root=/dev/sda1 ABAT:1154470592 
profile=2)
[...]
Kernel command line: root=/dev/sda1 ro profile=2 console=tty0 
console=ttyS0,57600 autobench_args: root=/dev/sda1 ABAT:1154470592 profile=2
[...]
elm3b6:~# cat /proc/cmdline
root=/dev/sda1

This seems to be occuring around the parse_args area.

Will try and track it down.

-apw
