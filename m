Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269022AbRHFVuf>; Mon, 6 Aug 2001 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269028AbRHFVuP>; Mon, 6 Aug 2001 17:50:15 -0400
Received: from www.microgate.com ([216.30.46.105]:19982 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S269022AbRHFVuN>; Mon, 6 Aug 2001 17:50:13 -0400
Message-ID: <002f01c11eca$1db590f0$8119fea9@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Matt Schulkind" <mschulkind@sbs.com>, <linux-ppp@vger.kernel.org>,
        <paulus@samba.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3810755D5165D2118F4400104B36917AC4FD34@normandy>
Subject: Re: Syncppp
Date: Mon, 6 Aug 2001 16:49:56 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the 2.2.16 kernel, it seems that the ppp_device structure was changed to
> use a pointer to the net device instead of haveing the structure contained
> within, and the if_down procedure was changed accordingly to use the sppp_of
> macro. But, if I take a look at the 2.4.x kernel sources, it seems only the
> first change, the pointer vs. struct change was made, but the if_down
> procedure was not changed. I believe this is a bug and the if_down procedure
> in the 2.4.x kernel must be changed to match 2.2.16+. Could anyone confirm
> this?
> -Matt Schulkind

It looks like you are right. The current 2.4 code
appears to scribble into the net_device structure
someplace (yuck) when if_down() is called.

I'm going to change this and test it tomorrow to be
for sure.

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


