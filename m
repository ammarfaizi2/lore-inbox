Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbSJBWkx>; Wed, 2 Oct 2002 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262671AbSJBWkx>; Wed, 2 Oct 2002 18:40:53 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:46090 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262663AbSJBWkv>;
	Wed, 2 Oct 2002 18:40:51 -0400
Date: Wed, 2 Oct 2002 15:43:43 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Corry <corryk@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021002224343.GB16453@kroah.com>
References: <02100216332002.18102@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02100216332002.18102@boiler>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 04:33:20PM -0500, Kevin Corry wrote:
> 
> Thank you very much for taking the time to consider this
> submission. If you have any questions or comments, please email
> us at any time. We will be happy to do whatever is necessary to
> make EVMS acceptable for inclusion in the 2.5 tree.

Some comments on the code:
	- you might want to post a patch with the whole evms portion of
	  the code, for those people without BitKeeper to see.
	- The #ifdef EVMS_DEBUG lines are still in AIXlvm_vge.c, I
	  thought you said you were going to fix this file up?
	- The OS2 and S390 files don't look like they have been fixed,
	  like you said you would before submission.
	- evms_ecr.h and evms_linear.h have a lot of unneeded typedefs.
	- the md code duplication has not been addressed, as you said it
	  would be.
	- the BK repository contains a _lot_ of past history and merges
	  that are probably unnecessary to have.  A few, small
	  changesets are nicer to look at :)

Why don't you propose a small evms patch that adds the core
functionality, and worry about getting all of the plugins and other
assorted stuff in later?  You will probably get more constructive
comments, as wading through a patch 37956 lines long is a bit difficult.

thanks,

greg k-h
