Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRJESHm>; Fri, 5 Oct 2001 14:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277534AbRJESHW>; Fri, 5 Oct 2001 14:07:22 -0400
Received: from ns.caldera.de ([212.34.180.1]:32142 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S277532AbRJESHO>;
	Fri, 5 Oct 2001 14:07:14 -0400
Date: Fri, 5 Oct 2001 20:07:35 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: John Byrne <john.l.byrne@compaq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Change in add_gendisk() in 2.4.11-preXXX
Message-ID: <20011005200735.A22840@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	John Byrne <john.l.byrne@compaq.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BBDF5B8.A6B649A3@compaq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBDF5B8.A6B649A3@compaq.com>; from john.l.byrne@compaq.com on Fri, Oct 05, 2001 at 11:02:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 11:02:32AM -0700, John Byrne wrote:
> 
> Cristoph,
> 
> Looking in the Changelog for 2.4.11-pre, I find that you are given
> credit for the change to add_gendisk() which should prevent the
> /proc/paritions loop; which is good.

In fact it was Alan's fix, I just sent it to Linus 8)

> However, I was tracing the bug
> myself and come to the conclusion the culprit in my case was the "sd"
> driver. One of our systems has two different SCSI HBAs and this resulted
> in two calls to sd_finish() which results in the sd_gendisk structures
> being added twice and, hence, the loop. So, I am a little concerned that
> your change is covering up the problem so well, that the actual issue
> may not be addressed. Unfortunately, I don't understand the ins and outs
> of the SCSI and blkdev layers to suggest a fix for "sd".

If you look at the new add_gendisk structure it is clearly marked that
the new bahaviour is a workaround.

It will be fixed in 2.5, but the scsi layer is too fragile to do such
changes in 2.4.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
