Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284248AbRLTLuH>; Thu, 20 Dec 2001 06:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284322AbRLTLt5>; Thu, 20 Dec 2001 06:49:57 -0500
Received: from holomorphy.com ([216.36.33.161]:30089 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S284248AbRLTLtt>;
	Thu, 20 Dec 2001 06:49:49 -0500
Date: Thu, 20 Dec 2001 03:49:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: aio
Message-ID: <20011220034942.A2632@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011219.213910.15269313.davem@redhat.com> <Pine.LNX.4.33.0112201127400.2656-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0112201127400.2656-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Dec 20, 2001 at 11:44:05AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 11:44:05AM +0100, Ingo Molnar wrote:
> we need a sane interface that covers *all* sorts of IO, not just sockets.
> I used to have exactly the same optinion as you have now, but now i'd like
> to have a common async IO interface that will cover network IO, block IO
> [or graphics IO, or whatever comes up]. We should have something saner and
> more explicit than a side-branch of fcntl() handling the socket fasync
> code.

I second this wholeheartedly. And I believe there are still more
motivations for providing asynchronous interfaces for all I/O in
the realm of assisting the userland:

(1) It would simplify the ways applications have and the kernel
	overhead of responding to user input while I/O is in progress.

(2) It would provide a more efficient way to do M:N threading than
	watchdogs and nonblocking poll/select in itimers.


Cheers,
Bill
