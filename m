Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266404AbUBFDpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUBFDpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:45:21 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:53770 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S266404AbUBFDpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:45:14 -0500
Date: Thu, 5 Feb 2004 19:45:09 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2] Documentation/SubmittingPatches
Message-ID: <20040206034509.GI21479@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20040205072303.BCF79FA5F1@mrhankey.megahappy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205072303.BCF79FA5F1@mrhankey.megahappy.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: For a better outlook on computing run Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 11:23:03PM -0800, Bryan Whitehead wrote:
> 
> I've been trying to get my feet wet by submitting trivial patchs to various maintainers and the responses have been, "your not submiting you patches correctly". It seems most developers/maintainers want a diff done like this:
> 
> cd /source-tree
> diff -u linux-2.6.2/FileToPatch.orig linux-2.6.2/FileToPatch
> 
> instead of the "SubmitingPatches" document way:
> cd /source-tree/linux-2.6.2
> diff -u FileToPatch.orig FileToPatch
> 
> It would be _great_ if the Documentation was more accurate to the taste of developers/maintainers...
> 
> If the SubmittingPatches document is correct, then just toss this patch out because this won't be submitted right... ;)
> 
> --- linux-2.6.2/Documentation/SubmittingPatches.orig    2004-02-04 22:57:55.818563016 -0800
> +++ linux-2.6.2/Documentation/SubmittingPatches 2004-02-04 23:01:28.799185040 -0800
> @@ -33,13 +33,15 @@
>                                                                                                                                     
>  To create a patch for a single file, it is often sufficient to do:
>                                                                                                                                     
> -       SRCTREE= /devel/linux-2.4
> +       SRCTREE= /devel/
> +       SRCDIR= linux-2.4
>         MYFILE=  drivers/net/mydriver.c
>                                                                                                                                     
> -       cd $SRCTREE
> +       cd $SRCTREE/$SRCDIR
>         cp $MYFILE $MYFILE.orig
>         vi $MYFILE      # make your change
> -       diff -u $MYFILE.orig $MYFILE > /tmp/patch
> +       cd $SRCTREE
> +       diff -u $SRCDIR/$MYFILE.orig $SRCDIR/$MYFILE > /tmp/patch
>                                                                                                                                     

For what it may be worth I find patches a lot more useful
for review purposes if the -p (for --show-c-function) option
is also used.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
