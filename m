Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbTKTDSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 22:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTKTDSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 22:18:21 -0500
Received: from CPE-138-130-214-20.qld.bigpond.net.au ([138.130.214.20]:11224
	"EHLO mx.jeeves.bpa.nu") by vger.kernel.org with ESMTP
	id S264253AbTKTDSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 22:18:20 -0500
From: Ben Hoskings <ben@jeeves.bpa.nu>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: transmeta cpu code question
Date: Thu, 20 Nov 2003 13:18:17 +1000
User-Agent: KMail/1.5.4
References: <20031120020218.GJ3748@schottelius.org> <20031120025315.GR11983@phunnypharm.org>
In-Reply-To: <20031120025315.GR11983@phunnypharm.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311201318.17705.ben@jeeves.bpa.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EDIT: Oops, meant to reply-all. Apologies Ben.

On Thu, 20 Nov 2003 12:53 pm, Ben Collins wrote:
> You are a bit confused. The cpu_rev is a 4 byte value, each byte is a
> decimal of the revision.
>
> And (0 & 1) makes 1, not 0. That's an AND, not an OR.

I'm willing to put some safe money on (0 & 1) equalling 0.

It has to, for your explanation below to work. :)

>
> Think about it this way. If cpu_rev == 0x01040801, then this would
> produce:
>
> (0x01040801 >> 24 & 0xff) -> (0x01 & 0xff) ->     0x01
>
> (0x01040801 >> 16 & 0xff) -> (0x0104 & 0xff) ->   0x04
>
> (0x01040801 >> 8  & 0xff) -> (0x010408 & 0xff) -> 0x08
>
> (0x01040801 & 0xff)                            -> 0x01

-- 
Ben

