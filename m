Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTLSUcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTLSUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:32:43 -0500
Received: from holomorphy.com ([199.26.172.102]:9112 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263638AbTLSUck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:32:40 -0500
Date: Fri, 19 Dec 2003 12:32:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Message-ID: <20031219203227.GR31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christian Meder <chris@onestepahead.de>,
	linux-kernel@vger.kernel.org
References: <1071864709.1044.172.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071864709.1044.172.camel@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 09:11:50PM +0100, Christian Meder wrote:
> I've got a longstanding regression in gnomemeeting usage when switching
> between 2.4 and 2.6 kernels.
> Phenomenon: 
> Without load gnomemeeting VOIP connections are fine. As soon as some
> load like a kernel compile is put on the laptop the gnomemeeting audio
> stream is cut to pieces and gets unintelligible . On 2.4.2x I don't get
> even the slightest distortion in the audio stream under load. I played
> around with different nice levels with no success. The problem persisted
> during the whole 2.6.0-test series no matter whether I used -mm kernels
> or pristine Linus kernels. Even when nicing the kernel compile to +19
> the distortions start right away. I tried Nick Piggin's scheduler which
> fared slightly better after changing the nice level of gnomemeeting to
> -10 but it's still a far cry from the 2.4.2x feeling without any
> fiddling with nice values.
> Any hints where to start looking are greatly appreciated.

Please instrument your workload with the following, and send logs of the
output (preferably compressed) to me and possibly others:

top b d 5
vmstat 5
while true; do cat /proc/vmstat; sleep 5; done
while true; do cat /proc/meminfo; sleep 5; done

A good way to log commands like this is:

(command) > /home/foo.log.1 2>&1 &

where parentheses surround the command in the actual shell input.


-- wli
