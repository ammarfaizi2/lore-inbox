Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWFAPcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWFAPcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWFAPcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:32:22 -0400
Received: from smtp-out.google.com ([216.239.45.12]:25269 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030198AbWFAPcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:32:21 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=Dtt6bB6d3p+vTGsSnDnE0nEpKab7J4SZ8mmg0JnyI5hlIgJPs7RYfQZcC6nNqhejJ
	pejZx1IKT0Ed/QFBEJxoA==
Message-ID: <447F084C.9070201@google.com>
Date: Thu, 01 Jun 2006 08:31:24 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com> <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com> <20060531225013.GA7125@elte.hu> <Pine.LNX.4.64.0606011222230.17704@scrub.home> <447EFE86.7020501@google.com> <Pine.LNX.4.64.0606011659030.32445@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606011659030.32445@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 1 Jun 2006, Martin J. Bligh wrote:
> 
> 
>>That doesn't seem to cover what we talked about clearly at all ?
>>I suppose the _ALL stuff is meant to cover stuff with overhead,
>>but frankly, what Ingo did seemed much clearer to me.
> 
> 
> It just didn't make much sense, a config option only to configure the 
> default value of unseen values?
> If we have too many debug options, I don't mind to hide them behind an 
> advanced config option, but their default values should not differ between 
> their visible and hidden state, so that the user sees the real values when 
> he enables the advanced option.
> A config option which only configures the default values is much less 
> useful, in an already configured kernel it's completely useless to an user 
> who only wants to enable some runtime checks and unless he reads the help 
> text _carefully_, he might even think that he just enabled some runtime 
> checks. 

Did you read the discussion that lead up to it? I thought that quite
clearly described why such a thing was needed.

Config options need to clearly distinguish what they're for, or people
will screw them up ... given:

config DEBUG_RUNTIME_CHECKS
	bool "Enable runtime debug checks"

config DEBUG_RUNTIME_CHECKS_ALL
	bool "Enable all runtime debug checks"
	depends on DEBUG_RUNTIME_CHECKS

... how is either the user meant to know under which of these to find
things, or the coder introducing a new feature supposed to know where
to put stuff? They're not very descriptive.

Please can we have a more constructive discussion that "it's wrong,
nack" ?

M.
