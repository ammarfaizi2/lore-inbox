Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVKBSki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVKBSki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVKBSkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:40:37 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:265 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965154AbVKBSkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:40:37 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: fs/fat - fix sparse warning
References: <20051031113639.GA30667@home.fluff.org>
	<87zmophiwp.fsf@devron.myhome.or.jp> <20051102180401.GA4272@stusta.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 03 Nov 2005 03:39:32 +0900
In-Reply-To: <20051102180401.GA4272@stusta.de> (Adrian Bunk's message of "Wed, 2 Nov 2005 19:04:01 +0100")
Message-ID: <87br12c2sb.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> It sometimes happens that the signature of a function changes and it is 
> forgotten to update all prototypes.
>
> If the prototype is in a header file, gcc tells about the mistake.
>
> If the prototype is in the C file gcc can't help us and it might take 
> some time until someone tracks the source of the nasty runtime problems 
> this might cause.
>
> It's your choice as subsystem maintainer which header file the 
> prototypes should go into - it is only important that both the file with 
> the actual function and all users of this function #include this header.

Sounds reasonable, although that's unlikely, because those are
init/exit functions.  OK, I'll do this in header cleanup as soon as possible.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
