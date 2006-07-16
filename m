Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWGPW5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWGPW5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 18:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWGPW5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 18:57:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:10469 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751330AbWGPW5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 18:57:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QILfBwqxaaj4ecHeTtaNaVcMZwbxU3jeQMSRsg1JZYlIZKqZjq1r4jhU7cqE0B09/n8kWO8ZI2E57zYgyN08Z+QNlkf1BmI+TuDmLUgrnHGjcE5DP5F0Cccc39jZxL+R7IKsOn7rqS1jD5DrV+hnSPVOE59ql7DADbR1izCV/48=
Message-ID: <e0e4cb3e0607161557l4a24ca4by4a6d9909feb8b1b1@mail.gmail.com>
Date: Sun, 16 Jul 2006 15:57:45 -0700
From: "Jonathan Baccash" <jbaccash@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: raid io requests not parallel?
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200607161609_MC3-1-C52A-F449@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607161609_MC3-1-C52A-F449@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because a single read not only goes to just one disk, it is sent to
> the disk with the lowest expected seek time for that request.  This
> cuts average read time in half, on average.
>
> (See drivers/md/raid1.c::read_balance().)

Thanks Chuck! That is making some sense, although I think I'll have to
read and think about it some more before I quite understand.

> You didn't post any benchmarks showing results for single write to a
> single disk.

I didn't think I could get any repeatable results for a single write,
so I was trying to understand what is happening based on runs of
longer writes.
