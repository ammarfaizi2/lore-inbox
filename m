Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUICGmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUICGmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 02:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUICGmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 02:42:51 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:10654 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S269080AbUICGmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 02:42:50 -0400
Message-ID: <41381272.70906@fy.chalmers.se>
Date: Fri, 03 Sep 2004 08:42:58 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Wilson <gww@btinternet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with cdrom-range-fixes-patch in 2.6.9-rc1-mm2
References: <41372971.4060600@btinternet.com>
In-Reply-To: <41372971.4060600@btinternet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Wilson wrote:
> Hi,
> With this patch applied a CDROMVOLREAD ioctl returns EINVAL.  I believe 
> that this is because of an error in the 'sanity check' added by the patch:
> 
> if ((buffer[offset] & 0x3f) == GPMODE_AUDIO_CTL_PAGE ||
>                             ^^
>                  should be  !=

Yes, absolutely. It should be != GPMODE_AUDIO_CTL_PAGE. Thanks! A.
