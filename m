Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWEVWal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWEVWal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWEVWal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:30:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:49049 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751274AbWEVWak convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:30:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DHIdh43esEedCekXAJC5T7L3Xa6smpskS/I1Ti9JyRKAF5Ow2UBy5XUe6n33O4rrTTG7yqll/1Yl65acjLls2WoVPKFDIQCXPTtTDVpLK+2RsxyVIDaYhXNZQ8Fhbvk1qpmTs7WZshgIOEu+roxvkhTOGUJE9Qr1dXwKZKveZ7U=
Message-ID: <305c16960605221530h68e8e3c5s849eb66f4881593e@mail.gmail.com>
Date: Mon, 22 May 2006 19:30:37 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: fitzboy <fitzboy@iparadigms.com>
Subject: Re: tuning for large files in xfs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <447209A8.2040704@iparadigms.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <447209A8.2040704@iparadigms.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, fitzboy <fitzboy@iparadigms.com> wrote:
> I've got a very large (2TB) proprietary database that is kept on an XFS
> partition under a debian 2.6.8 kernel. It seemed to work well, until I
> recently did some of my own tests and found that the performance should
> be better then it is...
>
> basically, treat the database as just a bunch of random seeks. The XFS
> partition is sitting on top of a SCSI array (Dell PowerVault) which has
> 13+1 disks in a RAID5, stripe size=64k. I have done a number of tests
> that mimic my app's accesses and realized that I want the inode to be
> as large as possible (which in an intel box is only 2k), played with su
> and sw and got those to 64k and 13... and performance got better.
>
> BUT... here is what I need to understand, the filesize has a drastic
> effect on performance. If I am doing random reads from a 20GB file
> (system only has 2GB ram, so caching is not a factor), I get
> performance about where I want it to be: about 5.7 - 6ms per block. But
> if that file is 2TB then the time almost doubles, to 11ms. Why is this?
> No other factors changed, only the filesize.
>
> Another note, on this partition there is no other file then this one
> file.
>

Why use a flesystem with just one file?? Why not use the device node
of the partition directly?
