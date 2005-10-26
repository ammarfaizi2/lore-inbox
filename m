Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbVJZNnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbVJZNnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 09:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVJZNnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 09:43:31 -0400
Received: from hera.kernel.org ([140.211.167.34]:43393 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751487AbVJZNnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 09:43:31 -0400
Date: Wed, 26 Oct 2005 06:39:56 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: =?iso-8859-1?Q?Hans-J=FCrgen?= Mehnert <hjmehnert@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel crashes 2.4.31final + 2.4.32rc1
Message-ID: <20051026083956.GA9473@logos.cnet>
References: <8e9415f80510240824g5b7bca95h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e9415f80510240824g5b7bca95h@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Oct 24, 2005 at 05:24:14PM +0200, Hans-Jürgen Mehnert wrote:
> [1.]
> PROBLEM: kernel crashes 2.4.31final + 2.4.32rc1
> 
> 
> [2.]
> Since kernel version 2.4.31 we have system crashes with
> blank screen and nothing in logs on at least 5 different
> Intel and AMD SMP machines. 2.4.32rc1 has the same problem,
> 2.4.30 is working stable on these machines. We had no crashes
> with the newer kernel versions on about 100 single-cpu machines
> so far.

Few questions:

- Can you send dmesg output?

- Are you using the ahci driver with the Intel SATA controller? There have
been some bugfixes in ahci during v2.4.31, although they dont look suspect.
Is there load on the interface?

- Is the USB UHCI controller being used? There are known SMP problems 
in the usb-uhci driver recently fixed (problem introduced in v2.4.28 though).

- What is the workload on these machines?

- Have you tried v2.4.31-pre1, -pre2, and so on to isolate the possibly problematic
change?


