Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUBYSx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUBYSu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:50:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31495 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261542AbUBYStc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:49:32 -0500
Message-ID: <403CEE33.3020601@zytor.com>
Date: Wed, 25 Feb 2004 10:49:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Early memory patch, revised
References: <403ADCDD.8080206@zytor.com> <m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> Two little tweaks I can think of.
> 1) Can we reserve space between __bss_stop and _end for the page
>    tables and the bitmap of memory?   
>    
>    This should make it obvious that the early boot code is touching
>    that memory.
> 

After thinking about this a little bit more, you will actually *cause*
boot failures on low memory machines if you do this.

Not cool.

	-hpa

