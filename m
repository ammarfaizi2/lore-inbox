Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVCRB75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVCRB75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVCRB75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:59:57 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:7610 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261373AbVCRB7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:59:55 -0500
Message-ID: <423A3617.6060406@g-house.de>
Date: Fri, 18 Mar 2005 02:59:51 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de>	 <2cd57c9005031102595dfe78e6@mail.gmail.com>	 <4231B4E9.3080005@g-house.de> <42332F9C.7090703@g-house.de>	 <4238DD01.9060500@g-house.de> <2cd57c90050317132570147e7c@mail.gmail.com>
In-Reply-To: <2cd57c90050317132570147e7c@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> I do "grep check-route.sh oom_2.6.11.3.txt | wc" and it shows 4365

duh, good catch! really!

> lines, which means there're 4365 that script processes running, from 
> pid 4260 to12747, mostly with pretty low points, 123.
> Based on this points, suppose each script consumes 100k, that'll be
> 100k*4k=400M roughly. And your box's is merely 256M MemTotal.

yes, i just checked, the script is looping and crond is starting a new
one, and another....and the oom-killer does not catch it, because it's too
small and of course don't know where it is coming from (crond).

> Check this script and disable it; see what will happen.

yes, will do that. on a (not so unimportant) side-note: i was told the
whole thing should be fixed with 2.6.11.4:

  [PATCH] CAN-2005-0384: Remote Linux DoS on ppp servers


after all it seems to be PEBKAC and bad luck...what a week.

thank you for your help,
Christian.
-- 
BOFH excuse #416:

We're out of slots on the server
