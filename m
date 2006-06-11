Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWFKBpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWFKBpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 21:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWFKBpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 21:45:04 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:29537 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750902AbWFKBpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 21:45:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b6lvjXg6lqJT3bZ2095Te6JuEaZcb0H6rAjfeHCGk2QyvK8QEfZ76voLvx2BXQ275JlAQVzNKCPOvv5oxoQUKHuCmfhtvNR5JQah0TYFB8dQVoj2UpwtvZp5Hw1sfb0L9jgyY7wYIjgbP04aW3YYaFc7BfYhM4jzpikjpHZS7wc=
Message-ID: <448B7594.6040408@gmail.com>
Date: Sun, 11 Jun 2006 09:44:52 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
References: <44893407.4020507@gmail.com>	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>	 <448AC8BE.7090202@gmail.com>	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	 <448B38F8.2000402@gmail.com>	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	 <448B61F9.4060507@gmail.com>	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com> <9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>
In-Reply-To: <9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > > I see now that you can have tty0-7 assigned to a different console
>> > > driver than tty8-63.
>> > > Why do I want to do this?
>> >
>> > Multi-head.  I can have vgacon on the primary card for tty0-7,
>> > fbcon on the secondary card for tty8-16.
>>
> 
> When I say dropped, I mean drop the feature of having multiple drivers
> simultaneously open by the VT layer. You would still be able to switch
> from vgacon to fbcon by using sysfs. You just wouldn't be able to use
> VT swap hotkeys between them.

Quoting you:

"Googling around the only example I could find was someone with a VGA
card and a Hercules card. They setup 8 consoles on each card."

How do you think they accomplished that? They did not rewrite the VT
layer, all they need to do is change the 'first' and 'last' parameter
passed to take_over_console() in mdacon.c.  This implies that the VT
layer already supports multiple active VT console drivers, maybe as
early as 2.2, and no, we won't remove that.

Tony 
