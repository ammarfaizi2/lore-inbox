Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281532AbRK0Qjl>; Tue, 27 Nov 2001 11:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0Qjb>; Tue, 27 Nov 2001 11:39:31 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:5645 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S280817AbRK0Qj3>; Tue, 27 Nov 2001 11:39:29 -0500
Date: Tue, 27 Nov 2001 08:49:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <Pine.LNX.4.33.0111271459400.14344-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111270847300.1576-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Ingo Molnar wrote:

>
> On Mon, 26 Nov 2001, Davide Libenzi wrote:
>
> > As I said in reply to Ingo patch, it'd be better to expose "number"
> > cpu masks not "logical" ( like cpus_allowed ). In this way the users
> > can use 0..N-1 ( N == number of cpus phisically available ) w/out
> > having to know the internal mapping between logical and number ids.
>
> yep, agreed. I've uploaded a new set-affinity syscall patch with your
> improvement added:
>
> 	http://redhat.com/~mingo/set-affinity-patches/set-affinity-2.4.16-A0
>
> i've only tested it on x86 which has a 1:1 mapping between physical and
> logical CPUs, but it should be fine on other architectures as well.

The snippet I sent yesterday should be corrected by checking if
cpu_{number,logical}_map(ii) is != -1 to avoid incorrect bit settings,
expecially from mask coming from user side.



- Davide


