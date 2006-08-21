Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWHUIjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWHUIjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWHUIjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:39:54 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:5084 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751151AbWHUIjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:39:54 -0400
Date: Mon, 21 Aug 2006 10:39:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Julio Auto <mindvortex@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17.9 Incorrect string length checking in
 param_set_copystring()
In-Reply-To: <18d709710608200917o4c062d6ewd216580a1022ad0f@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608211038480.22414@yvahk01.tjqt.qr>
References: <18d709710608200747k3323b23cq70eb52fdb9032554@mail.gmail.com>
 <18d709710608200917o4c062d6ewd216580a1022ad0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> As for 2.6.17.9, linux/include/linux/moduleparam.h suggests the user
>> of module_param_string() to set the maxlen parameter to
>> strlen(string), ie. '\0' excluded.
>
> Actually, sizeof(string), not strlen(string). Senseless typo here.
> Sorry, my bad. :)

With \0 excluded, you want strlen(string) or sizeof(string)-1.


Jan Engelhardt
-- 
