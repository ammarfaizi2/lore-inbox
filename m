Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316902AbSFQLOh>; Mon, 17 Jun 2002 07:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSFQLOg>; Mon, 17 Jun 2002 07:14:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28171 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316898AbSFQLOf>;
	Mon, 17 Jun 2002 07:14:35 -0400
Date: Mon, 17 Jun 2002 12:14:36 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Remove SCSI_BH
Message-ID: <20020617121436.R9435@parcelfarce.linux.theplanet.co.uk>
References: <20020616192253.Q9435@parcelfarce.linux.theplanet.co.uk> <20020616.222201.105585133.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020616.222201.105585133.davem@redhat.com>; from davem@redhat.com on Sun, Jun 16, 2002 at 10:22:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2002 at 10:22:01PM -0700, David S. Miller wrote:
>    From: Matthew Wilcox <willy@debian.org>
>    Date: Sun, 16 Jun 2002 19:22:53 +0100
>    
>    Hi, Linus.  This patch switches SCSI from a bottom half to a tasklet.
>    It's been reviewed, tested & approved by Andrew Morton, James Bottomley &
>    Doug Gilbert.  Please apply.
> 
> I always wanted to make this a per-cpu SOFTIRQ, there is no reason
> it can't be and it's important enough to deserve to be one.

I agree that it probably should become a softirq.  However, in its current
state, I'm not sure it would gain any advantage from becoming a softirq.
I think it would take someone with far more understanding of the SCSI
layer than I have to do this work properly.  My current motivation is to
eradicate bottom halves rather than to improve scsi.

If someone's maintaining a TODO list for the scsi subsystem, please include:

 * Convert scsi_bottom_half_handler to a softirq.

as one of the entries.

-- 
Revolutions do not require corporate support.
