Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTJEPnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 11:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTJEPnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 11:43:00 -0400
Received: from sisko.nodomain.org ([213.208.99.114]:49307 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S263130AbTJEPm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 11:42:59 -0400
Message-ID: <3F803BF7.30707@nodomain.org>
Date: Sun, 05 Oct 2003 16:42:47 +0100
From: Tony Hoyle <tmh@nodomain.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br
Subject: Re: Oops linux 2.4.23-pre6 on amd64
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org> <3F7F1D21.1070503@nodomain.org> <20031004205545.GB71123@colin2.muc.de> <3F7F4AFC.7000700@nodomain.org> <20031005092052.GC12880@colin2.muc.de> <3F802AD2.9010108@nodomain.org> <20031005153707.GB30792@colin2.muc.de>
In-Reply-To: <20031005153707.GB30792@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Very likely the devfs code in the kernel is buggy. It is known
> to be race hell, I wouldn't be surprised if it has 64bit bugs too.
> 
OK well I can do without devfs anyway.

The ehci-hcd problem I've eventually tracked down to a bug in the biarch 
modutils - compiling a pure 64bit version of modutils solves all the 
module loading problems, and even alsa started working :)

Tony

