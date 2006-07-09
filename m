Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWGIKHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWGIKHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIKHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:07:43 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:6776 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964892AbWGIKHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:07:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m+2NG6VnKG4spQPMTpqbgFVNgOIc6phob9obW36McLFEFycRyUjhY7uvNiqNhBCfRh8vPF2bkjKjBGX0hsDxGEbB40GuGJVCRT6lUMjpXJ29ViM564NTGHjl+0XdqlaVJVkzWTGhFZjyjutyGE00QcDdh3+Dcy/6if5C2ykqOd4=
Message-ID: <44B0D55D.2010400@gmail.com>
Date: Sun, 09 Jul 2006 18:07:25 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Opinions on removing /proc/tty?
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>	 <20060707223043.31488bca.rdunlap@xenotime.net>	 <9e4733910607072256q65188526uc5cb706ec3ecbaee@mail.gmail.com>	 <20060708220414.c8f1476e.rdunlap@xenotime.net> <9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com>
In-Reply-To: <9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 7/9/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
>> On Sat, 8 Jul 2006 01:56:02 -0400 Jon Smirl wrote:
>>
>> > On 7/8/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
>> > > I don't know how well this is an answer to your question,
>> > > but I would like to be able to find a list of registered "consoles,"
>> > > whether they be serial, usbserial, netconsole, lp, or whatever.
>> > > /proc/tty/drivers does that partially.
>> >
>> > Console is an overloaded word. Do you want to know where it is legal
>> > to send system log output to, or do you want to know where you can log
>> > in from? There was a thread earlier that talked a little about
>> > controlling this.
>>
>> I have a working definition:
>> I want to see a list of drivers that have called register_console().
>>
>> > > I have a patch that also does it in /proc/consoles:
>> > >   http://www.xenotime.net/linux/patches/consoles-list.patch
>> > > Is somewhere in /sys the right place to find a list of all consoles?
>> >
>> > /sys is the right place for this info but a class does not exist for
>> it yet.
>>
>> I want a list of registered consoles.  How would I express that in /sys ?
> 
> You could make the list appear as an attribute in
> /sys/class/tty/console. You will need to all a little sysfs code after
> the console tty device is created.
> 

That would violate the one file, one value rule and GregKH will drop
it like a hot potato.

A better solution is to have /sys/class/console.

Tony
