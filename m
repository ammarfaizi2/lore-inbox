Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129720AbQKQJFr>; Fri, 17 Nov 2000 04:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbQKQJFh>; Fri, 17 Nov 2000 04:05:37 -0500
Received: from marks-43.caltech.edu ([131.215.92.43]:1541 "EHLO
	velius.chaos2.org") by vger.kernel.org with ESMTP
	id <S129720AbQKQJFW>; Fri, 17 Nov 2000 04:05:22 -0500
Date: Fri, 17 Nov 2000 00:35:03 -0800 (PST)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
In-Reply-To: <Pine.LNX.4.21.0011170905030.19287-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.21.0011170026130.10109-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2000, Dan Aloni wrote:
> If you are right, I guess put_files_struct() of kernel/exit.c would
> have cleaned files_struct everytime someones called it. 
> Everywhere in the kernel, objects are freed when
> atomic_dec_and_test() returns true.

Indeed, after studying the asm in question I think I see how it ticks.
What is the reasoning behind reversing the result of the test instead of
returning the new value of the counter?

(Thanks for taking time to set me straight on this.  :)

-Jacob

-- 

Why you say you no bunny rabbit when you have little powder-puff tail?
                -- The Tasmanian Devil

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
