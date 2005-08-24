Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVHXBPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVHXBPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVHXBPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:15:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751292AbVHXBPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:15:37 -0400
Date: Tue, 23 Aug 2005 21:15:12 -0400
From: Dave Jones <davej@redhat.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update warnings
Message-ID: <20050824011512.GC23171@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050822081528.GA4418@elf.ucw.cz> <1124753566.5093.8.camel@localhost> <20050823125017.GB3664@elf.ucw.cz> <1124801595.4602.18.camel@localhost> <20050823150501.GA23171@redhat.com> <1124830428.4826.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124830428.4826.0.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 06:53:49AM +1000, Nigel Cunningham wrote:

 > > > > > - CPU Freq  (improving too)
 > > > > > It might be good to mention these areas too.
 > > > > Well, right; but those 'only' cause system to crash during suspend. I
 > > > > was talking about really dangerous stuff.
 > > > > Both usb and cpufreq seems to work okay here.
 > > > It depends on what you're using. I believe one of the usb root hub
 > > > drivers is okay, the others aren't. Similar for cpufreq.
 > > 
 > > If you know a specific cpufreq driver which has problems, I'm all ears.
 > 
 > Here's the report from a user that I'm thinking of:
 > 
 > http://lists.suspend2.net/lurker/message/20050822.140001.6bf4abfe.en.html

Tainted oopses are completely uninteresting to me.  I see nothing there
at all to go on to investigate any problem in the centrino driver.
That the cpufreq driver & some binary module doesn't play together nicely
isn't news btw, I've heard reports of both of the common binary 3d drivers
locking up when CPU scaling is used, and there is *nothing* we can do to
fix that. If those drivers are making assumptions that the cpu speed
will remain static, they're broken, and unfixable by us.

We have enough problems getting suspend working for users without
binary junk loaded, so as far as I'm concerned.. CLOSED->NOTABUG.

		Dave

