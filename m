Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSGRPUi>; Thu, 18 Jul 2002 11:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSGRPUi>; Thu, 18 Jul 2002 11:20:38 -0400
Received: from fungus.teststation.com ([212.32.186.211]:32265 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S318130AbSGRPUh>; Thu, 18 Jul 2002 11:20:37 -0400
Date: Thu, 18 Jul 2002 17:22:40 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 is not SMP friendly
In-Reply-To: <200207180817.12217.kelledin+LKML@skarpsey.dyndns.org>
Message-ID: <Pine.LNX.4.44.0207181713140.10423-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Kelledin wrote:

> By the way, what are these bugs with smbfs?  I haven't hit them
> on my dual ppro box, probably because the box never runs as a
> samba client (just a samba server).

If you have characters in the filenames that doesn't match the charset you
use locally it will end up thinking that the name is 0xffffffff long and
oops when it tries to access beyond the mapped memory. The old code just
put a ? in the string.

/Urban

