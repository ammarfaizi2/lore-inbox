Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSDQHvn>; Wed, 17 Apr 2002 03:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313613AbSDQHvm>; Wed, 17 Apr 2002 03:51:42 -0400
Received: from violet.setuza.cz ([194.149.118.97]:50188 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S293060AbSDQHvm>;
	Wed, 17 Apr 2002 03:51:42 -0400
Subject: Re: tcp/ip stack in user space
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020416185419.52395.qmail@web13208.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Apr 2002 09:51:43 +0200
Message-Id: <1019029903.383.6.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 20:54, X.Xiao wrote:
> i want to move tcp/ip stack(including routing and
> netfilter) to userspace, my goal is to trace all the
> instructions involved in a firewall and router since i
> don't know how to trace these instructions inside the
> kernel. i want to get something like:
> 
> incoming ip packets(a file)-->fake ISR-->tcp/ip
> stack-->outgoing ip packets( to /dev/null).
> 
> my question is: is it possible and relatively easy to
> move tcp/ip stack to user space?

Hi,

Eric is right, I've started a syncookie fw using a daemon process for
now, because this is the first time I meet the kernel sources on a
larger project.

I do this using the REDIRECT ( ipchains ) / QUEUE ( ipfilter ) targets,
to get the packets to userspace. Once there, you can do what you want
using libpcap or syuscalls.

Regards and hope this helps
Frank

> Do You Yahoo!?


