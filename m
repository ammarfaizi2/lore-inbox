Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268696AbUJEBwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268696AbUJEBwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 21:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJEBwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 21:52:47 -0400
Received: from vs-kg004.ocn.ad.jp ([210.232.239.83]:4341 "EHLO
	vs-kg004.ocn.ad.jp") by vger.kernel.org with ESMTP id S268696AbUJEBwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 21:52:39 -0400
From: Jason Stubbs <jstubbs@work-at.co.jp>
Organization: Work@ Inc
To: Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Date: Tue, 5 Oct 2004 10:53:09 +0900
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410041611.17000.jstubbs@work-at.co.jp> <200410041931.00159.jstubbs@work-at.co.jp> <20041004120535.3c68115a.akpm@osdl.org>
In-Reply-To: <20041004120535.3c68115a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410051053.09587.jstubbs@work-at.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 04:05, Andrew Morton wrote:
> update_defense_level() is calling si_meminfo() from timer context.  But
> si_meminfo takes non-irq-safe locks.
>
> Move it all to keventd context.

That appears to have fixed it. I'm running my regular test and, while 
interactivity is non-existent, it hasn't locked. I'll leave it going for 
another few hours and report back to confirm.

Much gratitude. I should go out and buy a kernel book so that I may some day 
be able to repay the favour. :)

Regards,
Jason Stubbs
