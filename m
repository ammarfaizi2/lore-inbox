Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281634AbRKUG46>; Wed, 21 Nov 2001 01:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281633AbRKUG4k>; Wed, 21 Nov 2001 01:56:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3692 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281631AbRKUG4B>; Wed, 21 Nov 2001 01:56:01 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <m1vgg41x3x.fsf@frodo.biederman.org>
	<20011120.222920.51691672.davem@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Nov 2001 23:37:03 -0700
In-Reply-To: <20011120.222920.51691672.davem@redhat.com>
Message-ID: <m1lmh01vg0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> I do not agree with your analysis.

Neither do I now but not for your reasons :)

I looked again we are o.k. but just barely.  mmput explicitly checks
to see if it is freeing the swap_mm, and fixes if we are.  It is a
nasty interplay with the swap_mm global, but the code is correct.

My apologies for freaking out I but I couldn't imagine mmput doing
something like that.

Eric
