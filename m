Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUIXUdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUIXUdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUIXUdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:33:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269117AbUIXUdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:33:39 -0400
Message-ID: <41548493.3000905@pobox.com>
Date: Fri, 24 Sep 2004 16:33:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Neil Horman <nhorman@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
References: <41547C16.4070301@pobox.com>  <4154805D.8030904@redhat.com> <1096057867.11589.19.camel@krustophenia.net>
In-Reply-To: <1096057867.11589.19.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Is this really a good idea?  I suspect it would be abused.  For example,
> people would mlock mozilla or openoffice to keep it from being paged out
> overnight when updatedb runs, where the real solution is to fix the
> problem with the VM that causes updatedb to force other apps to swap
> out. 

Use /proc/swappiness for this

It definitely helped for me.  I set it really low, around '10' or so.

	Jeff


