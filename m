Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVAPTdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVAPTdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVAPTdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:33:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:15064 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262555AbVAPTdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:33:22 -0500
Message-ID: <41EABFC5.3060002@osdl.org>
Date: Sun, 16 Jan 2005 11:25:57 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Nelson <james4765@cwazy.co.uk>
CC: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/13] remove cli()/sti() in drivers/char/*
References: <20050116135223.30109.26479.55757@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson wrote:
> This series of patches removes the last cli()/sti()/save_flags()/restore_flags()
> function calls in drivers/char.

to what end?

I guess I don't get it.  What makes these drivers SMP-safe now?

Or is this series of patches only done to kill off the use
of deprecated functions?  If that's the case, they could
easily give someone the (false) expectation that the drivers
are SMP-safe, couldn't they?  Well, ftape (for one) is still
marked as BROKEN_ON_SMP, but will people know why it's
marked that way?

Have you read Documentation/cli-sti-removal.txt ?

-- 
~Randy
