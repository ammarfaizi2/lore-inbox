Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbUJ1EVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUJ1EVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUJ1EVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:21:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5527 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262750AbUJ1EUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:20:51 -0400
Message-ID: <41807395.5010709@pobox.com>
Date: Thu, 28 Oct 2004 00:20:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 2.4] the perils of kunmap_atomic
References: <417EDE4C.20003@pobox.com> <1098833780.7298.25.camel@desktop.cunninghams>
In-Reply-To: <1098833780.7298.25.camel@desktop.cunninghams>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> DEBUG_HIGHMEM under 2.4). It would be good if any patch produced a
> warning if you call kunmap_atomic with the wrong kind of parameter.


Well, the compiler has a rather difficult time with that, since any 
kernel address is going to be void*, which C will nicely cast struct 
page* into.

	Jeff


