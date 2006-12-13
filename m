Return-Path: <linux-kernel-owner+w=401wt.eu-S964970AbWLMNiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWLMNiP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWLMNiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:38:15 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39736 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964970AbWLMNiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:38:14 -0500
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 08:38:13 EST
Date: Wed, 13 Dec 2006 16:27:31 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Tushar Adeshara <adesharatushar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kevent POSIX timers support.
Message-ID: <20061213132730.GA18244@2ka.mipt.ru>
References: <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com> <20061122104416.GD11480@2ka.mipt.ru> <20061123085243.GA11575@2ka.mipt.ru> <e8ac1af10612130521i2bc2032fl81c82b7c513b69c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <e8ac1af10612130521i2bc2032fl81c82b7c513b69c4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 13 Dec 2006 16:27:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Please _NEVER_ drop Cc: list, since not everyone can be subscribed to
linux-kernel@, fortunately I'm not for example.

On Wed, Dec 13, 2006 at 06:51:47PM +0530, Tushar Adeshara (adesharatushar@gmail.com) wrote:
> I think these four lines are not required. Irrespective of return
> value of kevent_user_add_ukevent(), we are going to release file, and
> return err.

> >+       if (err)
> >+               goto err_out_fput;
> >+
> >+       fput(file);
> >+
> >+       return 0;
> 
> 
> >+
> >+err_out_fput:
> >+       fput(file);
> >+err_out:
> >+       return err;
> >+}
> >+

I put them to always know where error path is and where it is not, so it
could be easier to put error statistic or debug.
It can be removed, but imho it reduces readability.

-- 
	Evgeniy Polyakov
