Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbTCLTUw>; Wed, 12 Mar 2003 14:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbTCLTUw>; Wed, 12 Mar 2003 14:20:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:18353 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261877AbTCLTTs>;
	Wed, 12 Mar 2003 14:19:48 -0500
Date: Wed, 12 Mar 2003 11:31:26 -0800
From: Andrew Morton <akpm@digeo.com>
To: jjs <jjs@tmsusa.com>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
Subject: Re: named vs 2.5.64-mm5
Message-Id: <20030312113126.703de259.akpm@digeo.com>
In-Reply-To: <3E6F7C78.1040302@tmsusa.com>
References: <3E6F7C78.1040302@tmsusa.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2003 19:30:22.0086 (UTC) FILETIME=[D2B5BA60:01C2E8CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jjs <jjs@tmsusa.com> wrote:
>
> Greetings -
> 
> 2.5.64-mm4 and -mm5 seem more rugged than previous
> kernels, but there are a couple of minor nits - one of them
> is the tendency of named (which appears to work reliably
> under 2.4) to go catatonic under recent 2.5.6x kernels -
> 
> More verbose kernel logging may shed some light - or is
> this just a red herring? I get a tons of these in 2.5.64-mm5:
> 
> <...>
> process `named' is using obsolete setsockopt SO_BSDCOMPAT
> process `named' is using obsolete setsockopt SO_BSDCOMPAT
> process `named' is using obsolete setsockopt SO_BSDCOMPAT
> <...>
> 

The changelog has:

# --------------------------------------------
# 03/03/08      jmorris@intercode.com.au        1.1083
# [NET]: Nuke SO_BSDCOMPAT.
# --------------------------------------------

Maybe James can tell us what is going on here.

We should at least place a cap on the number of times that message
is printed.
