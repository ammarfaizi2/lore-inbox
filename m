Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312577AbSCYVzK>; Mon, 25 Mar 2002 16:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312627AbSCYVzA>; Mon, 25 Mar 2002 16:55:00 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:5824 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S312577AbSCYVym>; Mon, 25 Mar 2002 16:54:42 -0500
Message-Id: <5.1.0.14.2.20020325134840.035020e0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 25 Mar 2002 13:53:39 -0800
To: Francois Romieu <romieu@cogenit.fr>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [Linux-ATM-General] Re: [PATCH] Updated ATM patch for
  2.4.19-pre4
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
        marcelo Tosatti <marcelo@conectiva.com.br>, Alan@lxorguk.ukuu.org.uk,
        cell@sch.bme.hu, linux-atm-general@lists.sourceforge.net
In-Reply-To: <20020324220622.A1054@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Comments welcome.
Looks ok to me.

>  static inline struct br2684_dev *BRPRIV(const struct net_device *net_dev)
>  {
>-       return (struct br2684_dev *) ((char *) (net_dev) -
>-           (unsigned long) (&((struct br2684_dev *) 0)->net_dev));
>+       return list_entry(net_dev, struct br2684_dev, net_dev);
>  }
Although list_entry does the same thing it's inappropriate here. People 
will be confused.

Max

