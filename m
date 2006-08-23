Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWHWKe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWHWKe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWHWKe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:34:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:30816 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964823AbWHWKe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:34:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=beHgHSULzU9e4eeIs0l+3+H1splvswcg7ukPlsq7xG70/QwTeDWXDTu+jYHQaO9p70sLobd+7kpdsfRGf/tI5PeUu4COg0bDKiQCdAKAnhzOZV+UTKWhjYxLQQdEq2RX93dFMX81Ew/uppWIuznzT7K6+NDQD99JtKJs5/VlqtU=
Message-ID: <b3f268590608230334y6814b886tb79da2f59138acd8@mail.gmail.com>
Date: Wed, 23 Aug 2006 12:34:25 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Cc: "David Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
In-Reply-To: <20060823102037.GA23664@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
	 <20060822231129.GA18296@ms2.inr.ac.ru>
	 <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
	 <20060822.173200.126578369.davem@davemloft.net>
	 <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	 <20060823065659.GC24787@2ka.mipt.ru>
	 <b3f268590608230122k60e3c7c7y939d5559d97107f@mail.gmail.com>
	 <20060823083859.GA8936@2ka.mipt.ru>
	 <b3f268590608230249q653e1dfh1d77c07f6f4e82ce@mail.gmail.com>
	 <20060823102037.GA23664@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> No, it will change sizes of the structure in kernelspace and userspace,
> so they just can not communicate.

struct kevent {
  uintptr_t ident;        /* identifier for this event */
  short     filter;       /* filter for event */
  u_short   flags;        /* action flags for kqueue */
  u_int     fflags;       /* filter flag value */

  union {
    u32       _data_padding[2];
    intptr_t  data;         /* filter data value */
  };

  union {
    u32       _udata_padding[2];
    void      *udata;       /* opaque user data identifier */
  };
};

I'm not missing anything obvious here, I hope.

Rakshasa
