Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVJHKjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVJHKjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVJHKjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:39:48 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:32454 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750963AbVJHKjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:39:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=OoZXRlT2ICgIyQpsbAxsAsuPvux+GJBLANkq80apmn1S5zTYrCbrjiAlpwyE5niEedtq4B8FiTWMQNFeKdf3c6+wic4S9cNztcISICh5t5dRn3+ikfHjG3fcz8jamgxouVoTP4cGS+nqiX4GB2Kn1s6NplX7RRHSJT44GRUjNoI=
Message-ID: <4347A1E7.2050201@pol.net>
Date: Sat, 08 Oct 2005 18:39:35 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: adaplas@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org>
In-Reply-To: <200510071547.14616.bero@arklinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> Hi,
> i810fb as a module is broken (checked with 2.6.13-mm3 and 2.6.14-rc2-mm1).
> It compiles, but the module doesn't actually load because the kernel doesn't 
> recognize the hardware (the MODULE_DEVICE_TABLE statement is missing).


> 
> The attached patch fixes this.
> 
> However, the resulting module still doesn't work.
> It loads, and then garbles the display (black screen with a couple of yellow 
> lines, no matter what is written into the framebuffer device).

Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a modprobe fbcon?
Does i810fb work if compiled statically?

Tony
