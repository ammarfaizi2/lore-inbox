Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262470AbTCIHsW>; Sun, 9 Mar 2003 02:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262471AbTCIHsW>; Sun, 9 Mar 2003 02:48:22 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:4224 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S262470AbTCIHsV>;
	Sun, 9 Mar 2003 02:48:21 -0500
Message-ID: <3E6AF463.4020706@portrix.net>
Date: Sun, 09 Mar 2003 08:59:31 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Console weirdness
References: <3E6A1A7F.8090409@portrix.net> <20030308131721.5254517a.akpm@digeo.com>
In-Reply-To: <20030308131721.5254517a.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jan Dittmer <j.dittmer@portrix.net> wrote:
> 
>>I'm not seeing any boot messages during boot up.
> 
> Try adding "console=/dev/tty0" to your kernel boot parameters.  Please
> report on the outcome.
> 

Okay, all of these fixes it.
console=ttyS0,38400n8 console=tty0
console=tty1
console=tty0

But still, switching back from X to console corrupts the display. 
Switching back is fine though using the fbdev.diff patch. Without 
switching back and force works fine, except that the last line isn't 
properly redrawn (rivafb).

Thanks, jan

