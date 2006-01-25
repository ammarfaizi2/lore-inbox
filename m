Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWAYXfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWAYXfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWAYXfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:35:01 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:38199 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751181AbWAYXfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:35:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=szclRJheRhB57zcIm2h3XcHVhyHEqMRz0MkkQBTT4db/zxfHAdm8+pL5GaTBnfo8yHULE5x8kbBJikLXbaBL/b5qx4U0r3rE8HqFKBnXrY+/WR84CcFw7/WexlKBEDZ2+G3MgOynaHEJFxkdgw2fTqEa/Gi4HUFoWXdhjf7Ilro=
Message-ID: <43D80B36.7040307@gmail.com>
Date: Thu, 26 Jan 2006 07:35:18 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Add support for soft scrollback
References: <43D492C4.3000801@gmail.com> <Pine.LNX.4.61.0601251451310.26305@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601251451310.26305@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> This patch adds this feature.  The feature and the size of the buffer
>> are made as a kernel config option.  Besides consuming kernel memory,
>> this feature will slow down the console by approximately 20%.
> 
> Slower?

Yes, I mentioned this before. The slowdown is unavoidable because the
contents of the scrollback is read from the VGA RAM.  It can be speeded
up but it will require an overhaul of vgacon to use buffers in system
RAM for the entire screen contents, visible and not visible.

Hard scrollback is still the default for vgacon, and soft scrollback
has to be selected during kernel config.

> Then I would rather prefer compact oopses.

Of course.

Tony
