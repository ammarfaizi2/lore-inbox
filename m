Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVKQVfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVKQVfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVKQVfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:35:44 -0500
Received: from nikola.com ([64.146.180.228]:22717 "EHLO nikola.com")
	by vger.kernel.org with ESMTP id S1751344AbVKQVfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:35:44 -0500
Message-ID: <00b501c5ebbe$dafc7960$5e00800a@printserver>
From: "Jesse Gordon" <jesseg@nikola.com>
To: "Jesse Gordon" <jesseg@nikola.com>, <linux-kernel@vger.kernel.org>
References: <200511121616.14940.ace@staticwave.ca> <200511161252.08927.bjorn.helgaas@hp.com> <009401c5eaeb$9a77be00$5e00800a@printserver>
Subject: Re: ICMP Ping being lost between kernel and the ping program. (Solved!)
Date: Thu, 17 Nov 2005 13:35:39 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-Authenticated-Sender: jesseg@nikola.com
X-Spam-Processed: nikola.com, Thu, 17 Nov 2005 13:35:37 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 64.146.180.228
X-Return-Path: jesseg@nikola.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: nikola.com, Thu, 17 Nov 2005 13:35:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
"Jesse Gordon" <jesseg@nikola.com> wrote:

>Subject: ICMP Ping being lost between kernel and the ping program.
>
> Greetings. This is my first post.
>
> I'm having a weird intermittent problem with ping.
>
> I'm pinging the WAN port of a cheap home DSL firewall (d-link di-604) and 
> sometimes the ping program fails to get a response,
> but if I run tcpdump I can see that the response is indeed coming back.
> .. snip ..
> -Jesse

Solved.

The Dlink firewalls were responding with stale ICMP Identifier when pinged a 
second time, and the ping program was ignoring the responses which had a 
stale Identifier.

The windows box always works because it always uses the same number for 
Identifier. Ugh.

Thanks!

-Jesse 


