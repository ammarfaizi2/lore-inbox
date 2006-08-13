Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWHMTjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWHMTjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWHMTjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:39:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:64845 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751372AbWHMTjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:39:40 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=cL5WEpMvbC8gRGs85ShdbbVcGVfdl7eMq3MjCEka1HHmMNInnMZ533qHinqrn6DqJ
	LDSho5FMJCzzG8EyyIVqA==
Message-ID: <44DF7FB9.8020003@google.com>
Date: Sun, 13 Aug 2006 12:38:33 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: jeff@garzik.org, a.p.zijlstra@chello.nl, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 8/9] 3c59x driver conversion
References: <20060808193447.1396.59301.sendpatchset@lappy>	<44D9191E.7080203@garzik.org>	<44D977D8.5070306@google.com> <20060808.225537.112622421.davem@davemloft.net>
In-Reply-To: <20060808.225537.112622421.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> I think he's saying that he doesn't think your code is yet a
> reasonable way to solve the problem, and therefore doesn't belong
> upstream.

That is why it has not yet been submitted upstream.  Respectfully, I
do not think that jgarzik has yet put in the work to know if this anti
deadlock technique is reasonable or not, and he was only commenting
on some superficial blemish.  I still don't get his point, if there
was one.  He seems to be arguing in favor of a jump-off-the-cliff
approach to driver conversion.  If he wants to do the work and take
the blame when some driver inevitably breaks because of being edited
in a hurry then he is welcome to submit the necessary additional
patches.  Until then, there are about 3 nics that actually matter to
network storage at the moment, all of them GigE.

The layer 2 blemishes can be fixed easily, including avoiding the
atomic op stall and the ->dev volatility .  Thankyou for pointing
those out.

Regards,

Daniel
