Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRCWRRT>; Fri, 23 Mar 2001 12:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRCWRRK>; Fri, 23 Mar 2001 12:17:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19206 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131269AbRCWRQ4>;
	Fri, 23 Mar 2001 12:16:56 -0500
Date: Fri, 23 Mar 2001 17:16:13 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt)
Message-ID: <20010323171613.H5491@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain>; from hbryan@us.ibm.com on Fri, Mar 23, 2001 at 09:56:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 09:56:47AM -0700, Bryan Henderson wrote:
> There's a lot of cool simplicity in this, both in implementation and 
> application, but it leaves something to be desired in functionality.  This 
> is partly because the price you pay for being able to use existing, 
> well-worn Unix interfaces is the ancient limitations of those interfaces 
> -- like the inability to return adequate error information.

hmm... open("defrag-error") first, then read from it if it fails?

> effective the defrag was?  And bear in mind that multiple processes may be 
> issuing commands to /mnt/control simultaneously.

you should probably serialise them.  you probably have to do this anyway.

> With ioctl, I can easily match a response of any kind to a request.  I can 
> even return an English text message if I want to be friendly.

yes, one of the nice plan9 changes was the change to returning strings
instead of numerics.

-- 
Revolutions do not require corporate support.
