Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTKKOLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTKKOLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:11:08 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:29111 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263523AbTKKOLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:11:06 -0500
Message-ID: <3FB0EEB5.5010804@myrealbox.com>
Date: Tue, 11 Nov 2003 06:14:13 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <fa.eto0cvm.1v20528@ifi.uio.no> <fa.onl48uv.1tmeb21@ifi.uio.no>
In-Reply-To: <fa.onl48uv.1tmeb21@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Tue, 11 Nov 2003, Nick Piggin wrote:
> 
> 
 >> What happens if the the tree is updated while the client is fetching 
 >> it [using a single LOCKfile method]?

 > Surprise, it breaks :-) Yes, the double file approach is needed
 > (excluding changes to rsync).


Sorry to be so dumb, but it seems to me that the two methods are exactly
equivalent in every way:

A test for file1 != file2 is exactly eqivalent to testing LOCK != NULL.
It's a simple binary TRUE/FALSE test.

What am I missing?  (BTW I'm not arguing against the two-file method.
I just don't understand why it's different.)

Now, if multiple people are updating the tree at the same time then a
simple TRUE/FALSE test provides insufficient information:  you would
then need enough 'bits' of information to count the number of people
updating at the same time.

But this problem is certainly not unique to this group.  Anyone using
a source repository has the same problem to deal with.  Or am I not
with the program here at all?
