Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVJHND3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVJHND3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 09:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVJHND3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 09:03:29 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:47522 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932098AbVJHND2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 09:03:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Eu2K4D24w1OpPVsc/e/13uB62W66snNRkYp5rYenSOHz1ZcpOC5oRGc1HfQSNMVm0OrL87YOrbF8ysDEYTid4WGTKzSFoxRqa6rpmTC7qom7cCYG3amUGU/Wh8F+WI5O0oYjgGp35H2kQ41d8EMqa9C455Kt4edq5Ss84e9sODY=
Message-ID: <4347C393.5090304@gmail.com>
Date: Sat, 08 Oct 2005 21:03:15 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net> <1308gutgj0dx4$.1ie66adezdlua$.dlg@40tude.net>
In-Reply-To: <1308gutgj0dx4$.1ie66adezdlua$.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Sat, 08 Oct 2005 18:39:35 +0800, Antonino A. Daplas wrote:
> 
>> Bernhard Rosenkraenzer wrote:
>>> Hi,
>>> i810fb as a module is broken (checked with 2.6.13-mm3 and 2.6.14-rc2-mm1).
>>> It compiles, but the module doesn't actually load because the kernel doesn't 
>>> recognize the hardware (the MODULE_DEVICE_TABLE statement is missing).
>>> The attached patch fixes this.
>>>
>>> However, the resulting module still doesn't work.
>>> It loads, and then garbles the display (black screen with a couple of yellow 
>>> lines, no matter what is written into the framebuffer device).
>> Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a modprobe fbcon?
>> Does i810fb work if compiled statically?
> 
> Since this is *really* coming out often: is there a specific reason
> why the fb modules do not depend on fbcon?
> 

Some need fbdev only, without fbcon, ie, embedded.

Tony
