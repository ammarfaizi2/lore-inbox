Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbSJIXXu>; Wed, 9 Oct 2002 19:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbSJIXXu>; Wed, 9 Oct 2002 19:23:50 -0400
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:3575 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S263207AbSJIXXt>; Wed, 9 Oct 2002 19:23:49 -0400
Date: Thu, 10 Oct 2002 00:29:02 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: "David S. Miller" <davem@redhat.com>
Cc: sekiya@sfc.wide.ad.jp, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021010002902.A3803@edi-view1.cisco.com>
References: <20021009170018.H29133@edinburgh.cisco.com> <uwuor9tg7.wl@sfc.wide.ad.jp> <20021009234421.J29133@edinburgh.cisco.com> <20021009.161414.63434223.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021009.161414.63434223.davem@redhat.com>; from davem@redhat.com on Wed, Oct 09, 2002 at 04:14:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 04:14:14PM -0700, David S. Miller wrote:
> 
> I think the change was made because some TAHI test
> failed without it, USAGI people is this right?
> 
> Most of USAGI changes are of this nature. :-)

There are areas where the TAHI tests expect a certain behaviour when
more than one behaviour is acceptable.

As I recall there is an issue around the behaviour of a packet being
received with a zero length payload.  The TAHI tests seem to expect
one type of ICMPv6 response,  whereas depending upon the value of
next header and the order in which header field validations occur,
two different types of ICMP error can be generated.

Specifically parameter problem identifying the payload field or the
next header field.  I seem to remember this being triggered when a
jumbo header is received by a node that doesn't understand jumbograms.

DF
