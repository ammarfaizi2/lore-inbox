Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRCNOHO>; Wed, 14 Mar 2001 09:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131364AbRCNOHE>; Wed, 14 Mar 2001 09:07:04 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:36548 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S131353AbRCNOGy>; Wed, 14 Mar 2001 09:06:54 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Date: Wed, 14 Mar 2001 15:05:50 +0100
Message-Id: <20010314140550.30460@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.05.10103141429440.24115-100000@callisto.of.borg>
In-Reply-To: <Pine.LNX.4.05.10103141429440.24115-100000@callisto.of.borg>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Either that, or the fbdev would register with PCI (or whatever), _and_
>> fbcon would too independently. In that scenario, fbcon would only handle
>> things like disabling the cursor timer, while fbdev's would handle HW
>> issues. THe only problem is for fbcon to know that a given fbdev is
>> asleep, this could be an exported per-fbdev flag, an error code, or
>> whatever. In this case, fbcon can either buffer text input, or fallback
>> to the cfb working on the backed up fb image (that last thing can be
>> handled entirely within the fbdev I guess).
>
>I'd go for a fallback to dummycon. It's of no use to waste power on creating
>graphical images of the text console when asleep. And the fallback to
dummycon
>is needed anyway while a fbdev is opened (in 2.5.x).

We do already have the backup image since we need to backup & restore the
framebuffer content.

Ben.



