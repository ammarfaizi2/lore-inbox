Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129508AbQKAQG0>; Wed, 1 Nov 2000 11:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130296AbQKAQGQ>; Wed, 1 Nov 2000 11:06:16 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:28670 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129508AbQKAQGK>; Wed, 1 Nov 2000 11:06:10 -0500
Date: Wed, 01 Nov 2000 08:09:16 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Linux's implementation of poll() not scalable?
To: Mike Jagdis <mjagdis@kokuacom.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        "linux-scalability@citi.umich.edu" <linux-scalability@citi.umich.edu>
Reply-to: dank@alumni.caltech.edu
Message-id: <3A00402C.6509D58A@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <LPBBLLNMNCOEDEJFALHPAEGBDMAA.mjagdis@kokuacom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Jagdis wrote:
> This patch firstly extends the wait queue mechanism
> to allow an arbitrary action to be performed. Then I rewrote
> the select/poll implementation to use event queueing to avoid
> rescanning descriptors that had not changed - and restructured
> the loops to be rather more efficient. This approach doesn't
> need any changes to driver poll routines, it doesn't need
> backwards mapping struct files. ...
>   Performance graphs and the lmbench derived test programs I
> used are at http://www.purplet.demon.co.uk/linux/select/ ...
>   Oh, and I updated this patch for 2.4.0-test9.

I can't wait to run my benchmark on it... hope I can get to it soon.
BTW, can you update that web page to also point to your patch?
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
