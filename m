Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUAGR4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUAGR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:56:12 -0500
Received: from hera.kernel.org ([63.209.29.2]:53196 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266284AbUAGR4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:56:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Wed, 07 Jan 2004 09:55:39 -0800
Organization: Zytor Communications
Message-ID: <3FFC481B.5030905@zytor.com>
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com> <20040106215018.GA911@sun.com> <3FFB316A.6000004@zytor.com> <20040106221502.GA7398@hockin.org> <20040106221502.GA7398@hockin.org> <3FFB34C9.5010305@zytor.com> <3FFC3187.4010004@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: terminus.zytor.com 1073498140 30326 66.80.2.163 (7 Jan 2004 17:55:40 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jan 2004 17:55:40 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:

> This is clearly not 'all of userspace'.  Autofs is an exception.  As is 
> /etc/mtab.  The way I see it, automounting is a 'mount facility', as are 
> namespaces.  The two should be made to work together.  Yes, mount(8) 
> should probably be fixed one way or another as well due to /etc/mtab 
> breakage. Why? Because it too is a mount facility.
> 
> There are a couple problems inherent with namespaces.  Most of these are 
> mount facilities that are broken such as mentioned above.  They *should* 
> be fixed to work nicely.

For that one needs to know how the namespaces are used, not just how 
they are implemented.  There was a long discussion on this on #kernel 
yesterday, by the way.

> Other parts of userspace get confused with namespaces, eg: cron and atd. 
>  These programs clearly need infrastructure added that somehow allows 
> for arbitrary namespace joining/saving.  If you have suggestions for how 
> we can solve this issue, please do let me know.  I'm stumped :\  I'd be 
> more than happy to discuss this with you.

Do they?  In order for that to be a "clearly", I believe one needs to 
understand how namespaces are used in practice.  It may not be desirable 
or even possible; this starts getting into a policy decision.

> One not-so-far fetched approach would be to associate cron/at jobs with 
> automount configurations so that a namespace can be re-constructed at 
> runtime.

I am not entirely sure what you mean with this, but it sounds incredibly 
dangerous to me.

	-hpa

