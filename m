Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbUKIXvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUKIXvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUKIXt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:49:58 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:33647 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261777AbUKIXsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:48:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iPeHi+bpaoGiFdLKJLTXMPPpPL46w/ZBIIWUj1WNgaZ+J2IKqJe/b41EVUszgSyM9u0QvGqun+t07BgyXS2IBrnmjx67gVU62gzoGkbAFa/aAlFJtESmu+y3lEFPVz4BKCftyiThEytD3nssLDShyjpmgo3p2llNzS7N5ccXDBg=
Message-ID: <d120d5000411091548584bf8c5@mail.gmail.com>
Date: Tue, 9 Nov 2004 18:48:17 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [ACPI] Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Kay Sievers <kay.sievers@vrfy.org>, tokunaga.keiich@jp.fujitsu.com,
       motoyuki@soft.fujitsu.com, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, rml@novell.com,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20041109225502.GC7618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041105001328.3ba97e08.akpm@osdl.org>
	 <20041105164523.GC1295@stusta.de> <20041105180513.GA32007@kroah.com>
	 <20041105201012.GA24063@vrfy.org> <20041105204209.GA1204@kroah.com>
	 <20041105211848.A21098@unix-os.sc.intel.com>
	 <20041109225502.GC7618@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004 14:55:02 -0800, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 05, 2004 at 09:18:48PM -0800, Keshavamurthy Anil S wrote:
> > Also, since you have brought this, I have one another question to you.
> > Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> > an "ADD" notification is sent. why is this? I would like to call
> > kobject_hotplug(kobj, ADD) later.
> 
> This happens when kobject_add() is called.  You shouldn't ever need to
> call kobject_hotplug() for an add event yourself.
> 

This is not always the case. One might want to postpone ADD event
until all summpelental object attributes are created. This way userspace
is presented with object in consistent state.

-- 
Dmitry
