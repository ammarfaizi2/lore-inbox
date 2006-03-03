Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWCCU0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWCCU0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWCCU0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:26:36 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:826 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932196AbWCCU0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:26:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z05RdtJITqjtO0lb+m0DKXnAGRM05xOp55l5hiAdRStJ0yZe/ydhjjxvIcNozWCeECJk6lfu0SOOPKuS+CtWKZ6oOv8LJ+br/CkcQqSMdFtCXG8VeAekizL9toXtejb5Jr8r5acHkH3pTxLonKsWuscJGWEykxZxkw2vpB4sNas=
Message-ID: <7c3341450603031226o55f6c77ah@mail.gmail.com>
Date: Fri, 3 Mar 2006 20:26:33 +0000
From: "Nick Warne" <nick@linicks.net>
Reply-To: "Nick Warne" <nick@linicks.net>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.4 patch] Corrected faulty syntax in drivers/input/Config.in
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
       "Willy Tarreau" <willy@w.ods.org>
In-Reply-To: <20060303180100.GV9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303180100.GV9295@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If statement in drivers/input/Config.in for "make xconfig" corrected.
>
>
> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
> This patch was sent by Stefan-W. Hahn on:
> - 26 Feb 2006
>
> --- a/drivers/input/Config.in
> +++ b/drivers/input/Config.in
> @@ -8,7 +8,7 @@ comment 'Input core support'
>  tristate 'Input core support' CONFIG_INPUT
>  dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
>
> -if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then
> +if [ "$CONFIG_INPUT_KEYBDEV" = "n" ]; then
>         bool '  Use dummy keyboard driver' CONFIG_DUMMY_KEYB $CONFIG_INPUT
>  fi

This was my patch, and after I saw that a bit later (Duh!), I did ask:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112966037407189&w=2

But got no feedback, and it was accepted, so I presumed all was OK.

So it looks like breaks in xconfig, and not menuconfig (what I use).

Nick
