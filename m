Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRAIOHr>; Tue, 9 Jan 2001 09:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRAIOHe>; Tue, 9 Jan 2001 09:07:34 -0500
Received: from zeus.kernel.org ([209.10.41.242]:24781 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130460AbRAIOHL>;
	Tue, 9 Jan 2001 09:07:11 -0500
Date: Tue, 9 Jan 2001 14:05:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109140504.D4284@redhat.com>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1>; from Venkateshr@ami.com on Mon, Jan 08, 2001 at 11:11:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 08, 2001 at 11:11:05PM -0500, Venkatesh Ramamurthy wrote:
> 
> 	> Max. RAM size:			64 GB	(any slowness
> accessing RAM over 4 GB
> *	with 32 bit machines ?)
> 	Imore than 4GB in RAM is bounce buffered, so there is performance
> penalty as the data have to be copied into the 4GB RAM area

Any memory over 1GB is bounce-buffered, but we don't use that memory
for anything other than process data pages or file cache, so only
swapping and disk IO to regular files gets the extra copy.  In
particular, things like network buffers are still all kept in the low
1GB so never need to be buffered.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
