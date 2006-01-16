Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWAPCYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWAPCYS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWAPCYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:24:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62885 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750839AbWAPCYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:24:17 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: fix make -jN with multiple targets with make O=... 
In-reply-to: Your message of "Mon, 16 Jan 2006 11:09:51 +0900."
             <dqev9f$pnc$1@sea.gmane.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Jan 2006 13:24:03 +1100
Message-ID: <7627.1137378243@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV (on Mon, 16 Jan 2006 11:09:51 +0900) wrote:
>Sam Ravnborg wrote:
>> [It is pushed out at:
>> git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git]
>> 
>> The way multiple targets was handled with make O=...
>> broke because for each high-level target make spawned
>> a parallel make resulting in a broken build.
>> Reported by Keith Owens <kaos@ocs.com.au>
>
>When did it break? Are any of the released (not -git) kernels affected?

2.6.15 has the problem.  It only triggers with the combination of a
separate object directory _and_ multiple targets on the make command
line _and_ running make in parallel (make -j).

