Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSFZVto>; Wed, 26 Jun 2002 17:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSFZVtn>; Wed, 26 Jun 2002 17:49:43 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:8953 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316959AbSFZVtn>; Wed, 26 Jun 2002 17:49:43 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.95.1020626100928.25416A-100000@chaos.analogic.com> 
References: <Pine.LNX.3.95.1020626100928.25416A-100000@chaos.analogic.com> 
To: root@chaos.analogic.com
Cc: Nicolas Bougues <nbougues-listes@axialys.net>,
       Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Problems with wait queues 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Jun 2002 22:49:30 +0100
Message-ID: <2014.1025128170@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For the benefit of any newcomers to the list who haven't clocked RBJ yet...

root@chaos.analogic.com said:
>  I am sure that you can have things look correct as well as run
> properly. However, you didn't show us the code. You need to do
> something like:

>             interruptible_sleep_on(&semaphore);

> while your wake-up occurs with:

>             wake_up_interruptible(&semaphore);

Do not ever use sleep_on() and friends. Almost all usage of these 
functions will be buggy.


--
dwmw2


