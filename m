Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTFFU5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 16:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTFFU5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 16:57:15 -0400
Received: from are.twiddle.net ([64.81.246.98]:32905 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262202AbTFFU5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 16:57:11 -0400
Date: Fri, 6 Jun 2003 14:10:42 -0700
From: Richard Henderson <rth@twiddle.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shared Library starter, ld.so
Message-ID: <20030606211042.GA30867@twiddle.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0306051045180.6171@chaos> <20030606101313.GA28939@twiddle.net> <Pine.LNX.4.53.0306060721400.4852@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306060721400.4852@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 07:34:50AM -0400, Richard B. Johnson wrote:
> .section .text
> .global _start
> .type	_start,@function
> _start:	call	*%edx
> 	pushl	$0
> 	call	exit
> .end
...
> On the Red Hat 9 system, it will segfault.

[vsop:~] gcc -nostartfiles zz.s
[vsop:~] ./a.out
[vsop:~] echo $?
0
[vsop:~] cat /etc/redhat-release 
Red Hat Linux release 9 (Shrike)

Works For Me.


r~
