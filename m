Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbUJXMv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUJXMv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 08:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUJXMv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 08:51:58 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:64755 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261462AbUJXMv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 08:51:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZiGvKLLSGagfuxFLkWDVFkTWglIaxNPku6DraBVdsMxG4T4uUSptCxiAnbh0SVjsc6yx9mMmlpe4l5jfO86swHaXgr3Vql3tYVR+dB6kjGKDY0VJuEUeEVvGEDWg9y0WWzWdfxPy/HteYZRFw/72oBr/Dl1AL3EOPhdP3polo2s=
Message-ID: <58cb370e041024055157a0b779@mail.gmail.com>
Date: Sun, 24 Oct 2004 14:51:56 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: IDE warning: "Wait for ready failed before probe!"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410241343.50664.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410241343.50664.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 13:43:50 +0100, Nick Warne <nick@linicks.net> wrote:
> >> 1. Are these warnings usual for a nonexistant IDE drive?
> >> 2. Could they be toned down?
> 
> > Disable CONFIG_IDE_GENERIC
> > - or -
> > Use the ideX=noprobe boot parm, replacing X with the interface number
> > not to probe.
> 
> > Kurt
> 
> I started to get these messages in logs since building 2.6.9, and a google
> reveals this from Alan Cox:
> 
> http://www.redhat.com/archives/fedora-test-list/2004-September/msg00300.html
> 
> So, will these be turned off, or do we have to follow above instructions?

Send a patch and it will be turned off (printks should be replaced by
pr_debugs). :)

It is still a good thing to disable ide-generic if it is not needed
(faster boot).
