Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266234AbUGOQMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUGOQMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 12:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUGOQMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 12:12:19 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:29863 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S266234AbUGOQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 12:12:17 -0400
X-Sasl-enc: 1svYqi54KtUH4dW/O433Bg 1089907936
Message-ID: <006801c46a86$81234230$9aafc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Chris Mason" <mason@suse.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
References: <00f601c46539$0bdf47a0$e6afc742@ROBMHP> <1089377936.3956.148.camel@watt.suse.com>
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.8-rc1)
Date: Thu, 15 Jul 2004 09:12:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded the kernel on a couple of the machines to 2.6.8-rc1 (compiled 
with debug symbols), but now we've seen two completely different types of 
failures

1. The same as the old one, where a couple of processes (half dozen in this 
case) would get stuck in D state, but the machine was otherwise pretty much 
fine
2. A new one where over 1000 processes get stuck within a short period of 
time and leave the machine is a very fragile state (even attempts to run 
'ps -auxw' freeze up)

I've placed all the results here:

http://robm.fastmail.fm/kernel/t3/

sysreqdmesg1-s1.txt - output of sysreq-t for system with a few procs in D 
state
sysreqdmesg2-s1.txt - same again, just done a second time
sysreqdmesg1-s2.txt - output of sysreq-t for system with 1000 procs in D 
state
vmlinux.gz - kernel image, built with debug symbols
config - config used to compile the kernel

Is there anything else I can provide? This problem is driving us crazy and 
I'd like to help in any way possible to try and get it investigated and 
resolved.

Rob

