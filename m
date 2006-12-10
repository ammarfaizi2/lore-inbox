Return-Path: <linux-kernel-owner+w=401wt.eu-S1760661AbWLJLK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760661AbWLJLK4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 06:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760666AbWLJLK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 06:10:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:26816 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760663AbWLJLK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 06:10:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GaqrA4CBWvEntjXw8jhy8L2/or/et2Yc43yVLwd09e/Oro0WH7ze4l9apH6IFJBjVudWOa9E8tYQx1HZRm+mAPdTijKPQ/mgAh3M6rE4D8KiRp77h4zC7Ue00zJgN3vHOAfwtZ/Mlv/OYOBMwsAUVAgPxjhfR56gaklmpqG1o3k=
Message-ID: <40f323d00612100310v176ff03es73ceeb520d631e4b@mail.gmail.com>
Date: Sun, 10 Dec 2006 12:10:54 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Amit Choudhary" <amit2030@yahoo.com>
Subject: Re: [PATCH] [DISCUSS] Optimizing linux applications with the help of the kernel.
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <464448.56474.qm@web55602.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <464448.56474.qm@web55602.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/06, Amit Choudhary <amit2030@yahoo.com> wrote:
> Hi All,
>
> I just had an idea for improving the performance of linux applications with some help from the
> kernel. Let's say that I have to make a copy of a file. So, I read the input file into a buffer
> and then write the buffer to the output file.
>
> In both these cases the same data is coming from kernel_to_user and then from user_to_kernel. If
> this can be short-circuited, that is, from kernel_to_kernel then the performance can be increased
> a lot.
>
> The psuedocode would be:
>
> fd_inp = open _output_file
> fd_out = open _input_file
> instruct_kernel to write next data read from fd_inp to fd_out
> read fd_out
>
>
I think you are describing the splice syscall:

see http://lwn.net/Articles/178199/

regards,

Benoit
