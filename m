Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWFFTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWFFTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWFFTp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 15:45:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:1505 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751027AbWFFTp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 15:45:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YfCKur+3IdRRSAnb/mEpfwPDDFNnpvVdniy4RrdB4PKpHfoBM1Mg+HcsbB+OStKvgQFSwzvQd6t82hn33uBoGuWo1j0BCtmn8CG7rH1JK6t4fRY0h78RhucC+60qDRaB2AgCtRopEIqesur875DLNsHKkWn9yP+w4OyZJB78RC8=
Message-ID: <4485DB6C.704@gmail.com>
Date: Wed, 07 Jun 2006 03:45:48 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Detaching fbcon
References: <44856223.9010606@gmail.com>	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com> <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>
In-Reply-To: <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/6/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > Overall, this feature is a great help for developers working in the
>> > framebuffer or console layer.  There is not need to continually
>> reboot the
>> > kernel for every small change. It is also useful for regular users
>> who wants
>> > to choose between a graphical console or a text console without
>> having to
>> > reboot.
>>
>> Instead of the sysfs attribute, what about creating a new escape
>> sequence that you send to the console system to detach? Doing it that
>> way would make more sense from a stacking order. It just seems
>> backwards to me that you ask a lower layer to detach from the layer
>> above it. The escape sequence would also work for any console
>> implementation, not just fbcon.
>>
>> If console detached this way and there was nothing to fallback to
>> (systems without VGAcon), it would know not to try and print anything
>> until something reattaches to it.
> 
> Another thought, controlling whether console is attached or not is an
> attribute of console, not of fbcon.

If the console attached fbcon, then I agree that console should decide
when to detach fbcon.  But that's not what happens, it's fbcon that
attaches itself.

It's not that you're wrong, it's just how the current vt/console layer
works.  If someone do decide to add this feature to the vt/console layer,
then I'm more than willing to have fbcon support that as well.
  
Tony
