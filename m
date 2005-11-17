Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbVKQBMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbVKQBMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbVKQBMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:12:07 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:61287 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161062AbVKQBMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:12:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tgVbJ5uIME6vlHtpDzVfOa3J+onUb5QRFICLamT0Yr5QNqpZ6s30S6798wGLh7icVx8Yb9mk+0qaEejRrV57s41g8Dkzr0Y9PdXhvp/NTplUM8B1C88AZI2Uyoigj2X/WthVcgx6oYmmBlArSWWBvW3Ckbfr0W9dv1TsYENmniM=
Message-ID: <437BD8D9.9030904@gmail.com>
Date: Thu, 17 Nov 2005 09:11:53 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: X and intelfb fight over videomode
References: <20051117000144.GA29144@hardeman.nu>
In-Reply-To: <20051117000144.GA29144@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman wrote:
> Using the information from this thread:
> http://marc.theaimsgroup.com/?t=112593256400003&r=1&w=2
> 
> I've now compiled a kernel with the intelfb and fbcon drivers linked in
> (no other fb drivers). By booting the kernel with vga=0x318 I get a
> 1024x768@16bpp console and drm/agp also seems happy.
> 
> However, as soon as X starts, the following message is printed to the
> kernel log:
> 
> mtrr: base(0xe0020000) is not aligned on a size(0x300000) boundary
> [drm:drm_unlock] *ERROR* Process 3013 using kernel context 0
> 
> Everything seems to work in X though. The first time that I switch from
> X to a vc, the screen stays black for a few seconds before I get the VC
> and then I get this:
> 
> intelfb: Changing the video mode is not supported.
> intelfb: ring buffer : space: 61488 wanted 65472
> intelfb: lockup - turning off hardware acceleration
> 
> I have X set to also use 1024x768@16bpp, what else do I need to do to
> make sure that intelfb and X play nice together?
> 

Try booting with video=intelfb:1024x768-16@60,mtrr=0. Do not include
the vga=0x318 option.  This prevents intelfb from changing the videomode.

Tony
