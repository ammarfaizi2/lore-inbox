Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUDERqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUDERqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:46:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58789
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263032AbUDERqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:46:17 -0400
Date: Mon, 5 Apr 2004 19:46:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eric Whiting <ewhiting@amis.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback
Message-ID: <20040405174616.GH2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40718B2A.967D9467@amis.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 10:36:58AM -0600, Eric Whiting wrote:
> The 4G/4G patch is still useful for me -- although 64bit linux (x86_64) is the
> best 'real' long-term solution to large memory jobs.  

what's your primary limitation? physical memory or virtual address
space? if it's physical memory go with 2.6-aa and it'll work fine up to
32G boxes included at full cpu performance.

if it's virtual address space and you've not much more than 4G of ram
3.5:1.5 usually works fine, and againt you'll run at full cpu
performance.

also make sure to move the task_unmapped_base at around 200M, so that
you get 1G more of address space for free.
