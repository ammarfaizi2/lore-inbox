Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270210AbRHGNdT>; Tue, 7 Aug 2001 09:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270211AbRHGNdJ>; Tue, 7 Aug 2001 09:33:09 -0400
Received: from www.microgate.com ([216.30.46.105]:29455 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S270210AbRHGNc7>; Tue, 7 Aug 2001 09:32:59 -0400
Message-ID: <008b01c11f4d$d01933e0$8119fea9@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Bob Dunlop" <Bob.Dunlop@farsite.co.uk>
Cc: "Matt Schulkind" <mschulkind@sbs.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3810755D5165D2118F4400104B36917AC4FD34@normandy> <002f01c11eca$1db590f0$8119fea9@diemos> <20010807102613.A18724@farsite.co.uk>
Subject: Re: Syncppp
Date: Tue, 7 Aug 2001 08:32:39 -0600
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

> On Intel (i386) it looks like it clobbers last_rx which is probably harmless,
> but it's close to some hairy pointers so who knows on other architectures.
> The fact that pp_link_state is not being reset could well explain how I was
> getting into that negotiation loop problem earlier in the year.  The loop
> fix is still a valid safety however.

Part of the problem is the masochistic construction of
the (ppp_device/net_device/struct sppp/serial context data)
quad. A nasty mess of casts and followed pointers
likely to make your head spin (and your code wrong).

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com




