Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVBRJcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVBRJcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 04:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVBRJcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 04:32:01 -0500
Received: from smtp7.wanadoo.fr ([193.252.22.24]:51211 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261317AbVBRJb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 04:31:56 -0500
X-ME-UUID: 20050218093155529.814791C000AD@mwinf0708.wanadoo.fr
Message-ID: <4215B5AC.4050600@innova-card.com>
Date: Fri, 18 Feb 2005 10:30:20 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk>
In-Reply-To: <20050217181241.A22752@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looking at TTY code, I noticed a weird test done in "opost_bock"
located in n_tty.c file. I don't understand why the following test is
done at the start of the function:
if (nr > sizeof(buf))
        nr = sizeof(buf);
Actually it limits the size of processing blocks to 4 bytes and I can't
find a reason why.

Second point, a lot of serial drivers call in their interrupt handler
"tty_flip_buffer_push" function. This function must no be called
in interrupt context. Why is it done anyway ?

Thanks for your answers.

       Franck

