Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWAMQc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWAMQc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWAMQc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:32:58 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:8411 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422734AbWAMQc5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:32:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=smh2F8rYKNxzWW9oEnrdDrY60vpVNjDoeCV4c8CThIbCvjTPW/2fGiK8kozQbhhGISzaa3iYWrDm6L7EB+vSU9MLY+QlnC4vY5JXw1SDFbwQZuWD9XUEIH+cu727JYmLfRBltyRNLvHwgNoJyhMOkBrcnXktV15rF0ZfDp+11jE=
Message-ID: <728201270601130832h37eae980hc4e0d3de7522c81e@mail.gmail.com>
Date: Fri, 13 Jan 2006 10:32:55 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Jim MacBaine <jmacbaine@gmail.com>
Subject: Re: /proc/sys/vm/swappiness == 0 makes OOM killer go beserk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3afbacad0601130755x507047eeqfdcfb1e54a163cdd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3afbacad0601130755x507047eeqfdcfb1e54a163cdd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Jim MacBaine <jmacbaine@gmail.com> wrote:
> Hello,
>
> the OOM killer just killed some of my processes while the system still
> had >2.5 GB of free swap. I'm running vanilla 2.6.15 on my desktop.
> The machine is a single Athlon64, 1 GB RAM, 3 GB swap, x86_64 kernel,

This is ok. When the swappiness variable  is set to zero kernel does
not try to swap out processes. So once all memory is used up by
processes it can not free up memory by swapping and hence had to kill
process.

Regards
Ram Gupta
