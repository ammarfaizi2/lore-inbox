Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWIARDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWIARDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWIARDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:03:08 -0400
Received: from stinky.trash.net ([213.144.137.162]:16844 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932454AbWIARDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:03:07 -0400
Message-ID: <44F86732.5060501@trash.net>
Date: Fri, 01 Sep 2006 19:00:34 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ondrej Zary <linux@rainbow-software.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops after 30 days of uptime
References: <200609011852.39572.linux@rainbow-software.org>
In-Reply-To: <200609011852.39572.linux@rainbow-software.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zary wrote:
> Hello,
> my home router crashed after about a month. It does this sometimes but this 
> time I was able to capture the oops. Here is the result of running ksymoops 
> on it (took a photo of the screen and then manually converted to plain-text). 
> Does it look like a bug or something other?


> Code;  c01eeb9e <init_or_cleanup+15e/160>
> 00000000 <_EIP>:
> Code;  c01eeb9e <init_or_cleanup+15e/160>   <=====
>    0:   8b 5e 18                  mov    0x18(%esi),%ebx   <=====
> Code;  c01eeba1 <ip_conntrack_protocol_register+1/70>
>    3:   11 d8                     adc    %ebx,%eax


This looks like a bug in some out of tree protocol module (2.4 only
contains the built-in protocols). Did you apply any netfilter patches?

