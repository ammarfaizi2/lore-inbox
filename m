Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVADHvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVADHvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 02:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVADHvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 02:51:38 -0500
Received: from [81.23.229.73] ([81.23.229.73]:49570 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261558AbVADHv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 02:51:27 -0500
From: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Organization: EduSupport BV
To: jerome lacoste <jerome.lacoste@gmail.com>
Subject: Re: 50% CPU user usage but top doesn't list any CPU unfriendly task
Date: Tue, 4 Jan 2005 08:51:23 +0100
User-Agent: KMail/1.6.2
References: <5a2cf1f6050103134611114dbd@mail.gmail.com>
In-Reply-To: <5a2cf1f6050103134611114dbd@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501040851.23287.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The load and the CPU useage are two separate things:
Load: Defined by a programmer on an estimate on which his program is running 
100% fulltime, thus consuming little or more CPU/IO.
The interesting program you mention is the VoIP application. Is this program 
multithreaded and is every thread using a little bit of CPU? Than it quickly 
adds up to the mentioned 40%. The load is than also easily reached.


On Monday 03 January 2005 22:46, jerome lacoste wrote:
> Hi,
>
> on a fairly old box used as a desktop (PII 300 Mhz with 196M RAM), I
> observe the following strange behavior which I believe comes from the
> kernel.
>
> There's a VoIP known 'P2P' closed source application running, an IP
> tables based firewall and a remote ssh session initiated. When using
> top, sorting by CPU usage, no program is using more than a couple of
> percent of CPU. On the other side, the total CPU user time is at
> around 40%, with a 1.5 load average. Memory looks OK. The machine is
> responsive as usual.
>
> So I wonder why the cpu user time is at 40% without any particular
> program showing as using CPU in the top listing. 'Problem' was
> reproducible with 2.4.x and now with 2.6.8.1.
>
> So it this a real problem or is there something that I don't
> understand in particular? Thanks for the insight.
>
> Jerome
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
