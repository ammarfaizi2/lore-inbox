Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUAGRvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUAGRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:51:12 -0500
Received: from hera.kernel.org ([63.209.29.2]:43980 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266262AbUAGRvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:51:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Wed, 07 Jan 2004 09:50:35 -0800
Organization: Zytor Communications
Message-ID: <3FFC46EB.9050201@zytor.com>
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it> <m3ad50tmlq.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: terminus.zytor.com 1073497835 30274 66.80.2.163 (7 Jan 2004 17:50:35 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jan 2004 17:50:35 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> I personally would be in favour of doing it all in the kernel because
> autofs3 and autofs4 are not fully compatible and break in subtle ways
> when not matching and in my experience when you have autofs3 compiled
> into the kernel the system happens to have an autofs 4 daemon
> installed and vice versa. Doing it in the kernel would avoid this
> nasty dependency problem.
> 

"Don't do that then."  Really.  Originally the autofs v3 filesystem was 
called "autofs" and the autofs v4 filesystem was called "autofs4" and 
the intent was that you should *never* run them across versions.

Jeremy tried nevertheless to be compatible (mistake #1) and Linus then 
renamed the autofs4 filesystem "autofs" (mistake #2).  There was no good 
reason for this and it should never have happened -- it broke the design 
that was intended to make sure the above wasn't going to be a problem.

> Also when /home or other important fs are mounted via autofs there is
> not much practical difference between a hung kernel and a hung
> daemon. You have to reboot the system anyways.

a) Guess which one is easier to debug?
b) Do people around here really believe that putting things in the 
kernel magically makes them work right?

	-hpa

