Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbTBTAho>; Wed, 19 Feb 2003 19:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTBTAho>; Wed, 19 Feb 2003 19:37:44 -0500
Received: from rth.ninka.net ([216.101.162.244]:38305 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264630AbTBTAho>;
	Wed, 19 Feb 2003 19:37:44 -0500
Subject: Re: [PATCH] IPSec protocol application order
From: "David S. Miller" <davem@redhat.com>
To: Tom Lendacky <toml@us.ibm.com>
Cc: "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <OF67D9F550.2E100257-ON86256CD2.007CE0BF-86256CD2.007E9FBD@pok.ibm.com>
References: <OF67D9F550.2E100257-ON86256CD2.007CE0BF-86256CD2.007E9FBD@pok.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 17:32:09 -0800
Message-Id: <1045704729.14999.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 15:03, Tom Lendacky wrote:
> I apologize if I missed it, but is there another way to set policy in the
> SPD besides the setkey command?  I am under the assumption that setkey's
> spdadd operation is what is to be used to define the policy on the system
> so that racoon can perform dynamic keying.

That's correct.

But there is still no issue.

The user can make his machine non-RFC compliant by giving a bogus
specification to setkey.  Kernel and setkey are merely doing what
the user asks of them.

This is akin to the user writing a RAW socket application which makes
the kernel output non-RFC compliant TCP packets.  Do you suggest that
the kernel or some other part of the system should verify the packets
sent through the RAW socket interface?  That is exactly what you are
telling us that setkey should be doing.

