Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWFPU4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWFPU4h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 16:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWFPU4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 16:56:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14999 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751225AbWFPU4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 16:56:36 -0400
Message-ID: <44931AFD.4070809@zytor.com>
Date: Fri, 16 Jun 2006 13:56:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Goo GGooo <googgooo@gmail.com>, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm2
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>  <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>  <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org> <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com> <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Actually, the really irritating thing is that we actually generate all 
> these nice status updates, which just makes pulling and cloning a lot more 
> comfortable, because you actually see what is going on, and what to 
> expect. 
> 
> Except they only work over ssh, where we have a separate channel (for 
> stderr), and with the native git protocol all that nice status work just 
> gets flushed to /dev/null :(
> 
> Dang. It's literally the most irritating part of the thing: the protocol 
> itself is exactly the same whether you go over ssh:// or over git://, but 
> that visual information about what is going on is missing, and it's 
> surprisingly important from a usability standpoint.
> 

Perhaps we shouldn't rely on stderr, and instead have a backchannel as part of the 
protocol itself.  After all, the protocol already does packetization, so all it needs is a 
reliable way to pick out the error/status packets; we could even combine that with a 
machine-readable code (like SMTP et al) that could get interpreted by the other side as 
needed.

	-hpa
