Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWBCVVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWBCVVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWBCVVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:21:36 -0500
Received: from smtp-relay.tamu.edu ([165.91.22.120]:8393 "EHLO
	smtp-relay.tamu.edu") by vger.kernel.org with ESMTP
	id S1030247AbWBCVVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:21:36 -0500
Message-ID: <43E3C950.5060203@tamu.edu>
Date: Fri, 03 Feb 2006 15:21:20 -0600
From: Benjamin Chu <benchu@tamu.edu>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux TCP/IP Accept Queue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I got few questions about the Linux kernel source code for 
implementing the TCP/IP.

 I just want to understand how the tcp/ip handle a incoming connection 
request from a remote client. As far as I know, after a connection 
request from a remote client completes the TCP 3-way handshake with the 
local server (in Established state). It would become an open request and 
this open request will be placed in the accept queue. At this point a 
new child socket is created and pointed to by the open request. And each 
time an "userspace application" (http, ftp..etc) process executes the 
"accept()" system call, the first open request in the accept queue is 
removed and the socket which is pointed to by this open request is 
returned.

 I tried to track the source code of the Linux kernel. My questions are:

 1. After a connection request from a client complete the TCP 3-way 
handshake(in Established state), does the function "tcp_acceptq_queue" 
in "tcp.h" must be called? Does this function handle the task which puts 
a new open request into accept queue ?.

 2. Each time the Web server process executes the accept() system call, 
 Does the function "tcp_accept" in "tcp.c" must be called. Does this 
function  handle the task which removes the first open request in the 
accept queue and return the socket which is pointed to by the open request?


Is there anything  which I describe above correct or not? Or there is 
any reference regarding this matter? Please tell me! Thank you very much!

p.s. My Linux Kernel Version is 2.4.25
