Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTIHSgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTIHSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:36:24 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:5136 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263465AbTIHSgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:36:22 -0400
Message-ID: <3F5CD12B.2060108@techsource.com>
Date: Mon, 08 Sep 2003 14:57:47 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Use of AI for process scheduling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got back from vacation and have 3278 list messages to sift 
through.  (Yay.)  I wouldn't be surprised, therefore, if others were 
already discussing this, but I've been thinking of some ideas over the 
past week that we may be helpful for the advancement of intelligent 
process scheduling.

To begin with, let's consider the parts of an intelligent system:

1) Inputs (ie. properties and behaviors of processes)
2) Heuristics
3) Outputs (ie. dynamic priorities, etc.)

Up to this point, the interactive scheduler has been designed in a very 
expert-system-like manner.  Human experts observe behaviors and define 
heuristics.  Ultimately, we do want a solid set of heuristics that are 
coded in C, and that's what the current development process has been 
working directly toward.

The progress has been slow, and there have been a lot of false starts 
and tangents which have been discarded.  This is all how development 
works, and it's important to explore all possibilities.  But what I 
would like to propose is that we work on a way to accelerate that 
process, and that is to make use of machine learning.  We move from 
expert systems to artificial intelligence, because the heuristics are 
determined by the machine and are therefore dynamic.

Basically, we need to write and install into the kernel an AI engine 
which uses user feedback about the "feel" of the system to adjust 
heuristics dynamically.  For instance, if the user sees that the system 
is misbehaving, they can pause the system in the kernel debugger, 
examine process priorities, and indicate what "outputs" from the AI 
engine are wrong.  It then learns from that.  Heuristics can be tweaked 
until things run as desired.  At that point, scheduler developers trade 
emails in the AI heuristic language.

Obviously, this AI engine will be slow and add a huge amount of 
processing overhead.  The idea is to determine what the heuristics are, 
and then to release a kernel, recode the heuristics in C.

