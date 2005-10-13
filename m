Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVJMCvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVJMCvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVJMCvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:51:18 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:37128 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751102AbVJMCvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:51:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o27fyRJUhWEIeIxlm+1SAE9W+sxgtcts10GD87ZsQ/cRHGylVYrlIkbO0BW4m/S7bl8y0C8K6O/4amkZ7kmlHeb+UwgjMthjFWtFQ0ys+Juh9RA4gbPllRrEnVNUwH2XTj2VpcM/TUX9Wokp+D4blrlQ3ocGQWWY6IiIG+Sn3Zg=
Message-ID: <434DCB97.8010406@gmail.com>
Date: Thu, 13 Oct 2005 10:51:03 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc3-git8 -- Failed to execute /etc/init lang=us apm=power-off
 root=/dev/hda6 video=nvidiafb:1024x768 ro nomce. Attempting defaults...
References: <a44ae5cd0510101729x52f31063l6e9d4eec468963ec@mail.gmail.com>
In-Reply-To: <a44ae5cd0510101729x52f31063l6e9d4eec468963ec@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:

> A possibly related problem I am attempting to track down is that
> nvidiafb is not correctly receiving it's video= option parameter. 
> Specifically, I am using:
> cat /proc/cmdline
> "init=/etc/init lang=us apm=power-off root=/dev/hda6
> video=nvidiafb:1024x768 ro nomce"
> But nvidiafb is only seeing:
> nvidiafb: mode_option = <NULL>
> 

Try this.  video=nvidiafb:off vga=0x0x305 video=vesafb:ypan

If you get the vesafb driver to run in ypan scrolling mode,
this problem may be specific to nvidiafb.

Tony

