Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbQKQFvq>; Fri, 17 Nov 2000 00:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130689AbQKQFvg>; Fri, 17 Nov 2000 00:51:36 -0500
Received: from marks-43.caltech.edu ([131.215.92.43]:53764 "EHLO
	velius.chaos2.org") by vger.kernel.org with ESMTP
	id <S130111AbQKQFva>; Fri, 17 Nov 2000 00:51:30 -0500
Date: Thu, 16 Nov 2000 21:21:13 -0800 (PST)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
Message-ID: <Pine.LNX.4.21.0011162103040.10109-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not (yet) a kernel guru, so just point and laugh if I'm wrong, but...

On Thu, 16 Nov 2000, Dan Aloni wrote:
> -               if (!--de->count) {
> +               if (atomic_dec_and_test(&de->count)) {

Doesn't this reverse the sense of the test?

-Jacob

-- 

"My my, the cruelest lies are often told without a word.
 My my, the kindest truths are often spoke, but never heard."

-Ben Folds Five, "The Last Polka"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
