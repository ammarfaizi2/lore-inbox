Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSKXOSC>; Sun, 24 Nov 2002 09:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKXOSC>; Sun, 24 Nov 2002 09:18:02 -0500
Received: from zero.aec.at ([193.170.194.10]:59915 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261339AbSKXOSB>;
	Sun, 24 Nov 2002 09:18:01 -0500
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format - how does one fix this?
References: <200211240859.35516.tomlins@cam.org>
From: Andi Kleen <ak@muc.de>
Date: 24 Nov 2002 15:25:05 +0100
In-Reply-To: <200211240859.35516.tomlins@cam.org>
Message-ID: <m3vg2nniym.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

> FATAL: Error inserting /lib/modules/2.5.49-mm1/kernel/ac97_codec.o: Invalid module format
> 
> I get this on about 10% of the modules I want to load.  How do I fix it?

readelf -r module_in_question.o

then look at arch/$ARCH/kernel/module.c and find out which relocation
is not implemented. Then implement it. Enabling DEBUGP there and in 
kernel/module.c may also help. 

-Andi
