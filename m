Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760138AbWLCWFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760138AbWLCWFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760135AbWLCWFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:05:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:49251 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1760136AbWLCWFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:05:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=B3rUELIiKFX4IANZUKr4+uGyQh4gf20xNcwTWZ6KmDUKCh8BbMpjRm+f7xwq/mcQ14/1fM/6rL6lW+a/2ToU6T+icdIBAxUAcqaWBdfU6WFzvdKpR3AHvLX29vvdbeoCf4Q7QG4AyQJpD44StRAOP/UwU0kNiaahe5q37O94kFU=
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Sun, 3 Dec 2006 23:05:15 +0100
User-Agent: KMail/1.9.5
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <1165173618.3233.243.camel@laptopd505.fenrus.org>
In-Reply-To: <1165173618.3233.243.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612032305.16567.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 December 2006 20:20, Arjan van de Ven wrote:
> this open_count thing smells fishy to me; what are the locking rules for
> it? What guarantees that the readers of it don't get the value changed
> underneath them between looking at the value and doing whatever action
> depends on it's value ?

Good point, a race condition could indeed occur in the only reader
that sends the signal to the userspace through the input device.
I'll fix this immediately.

Thanks,

Ivo
