Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUIPG6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUIPG6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUIPG6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:58:43 -0400
Received: from zero.aec.at ([193.170.194.10]:29190 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267806AbUIPG63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:58:29 -0400
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: get_current is __pure__, maybe __const__ even
References: <2ER4z-46B-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 16 Sep 2004 08:58:22 +0200
In-Reply-To: <2ER4z-46B-17@gated-at.bofh.it> (Albert Cahalan's message of
 "Thu, 16 Sep 2004 01:10:07 +0200")
Message-ID: <m3llfaya29.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

> Andi Kleen writes:
>
>> Please CSE "current" manually. It generates
>> much better code on some architectures
>> because the compiler cannot do it for you.
>
> This looks fixable.

I tried it some years ago, but I ran into problems with the scheduler
and some other code and dropped it.

One problem is that gcc doesn't have a "drop all const/pure
cache values" barrier. Without this I don't think it can be 
safely implemented.

-Andi

