Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSHPFfM>; Fri, 16 Aug 2002 01:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSHPFfM>; Fri, 16 Aug 2002 01:35:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45070 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318173AbSHPFfL>; Fri, 16 Aug 2002 01:35:11 -0400
Date: Thu, 15 Aug 2002 22:41:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Wellington <bwelling@xbill.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace/select/signal errno weirdness
In-Reply-To: <Pine.LNX.4.44.0208152112090.9595-100000@spratly.nominum.com>
Message-ID: <Pine.LNX.4.44.0208152241100.1488-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Brian Wellington wrote:
> 
> If that's the case, then how does
> 	fprintf(stderr, "select: %s\n", strerror(errno));
> print
> 	select: Unknown error 514
> ?
> 
> That's the traced process printing the error, not the tracing process.

Ahh, dang, there's a patch floating around for this case. Basically, 
tracing interferes with the normal behaviour (ie you _shouldn't_ see this 
normally, only when tracing system calls).

		linus

