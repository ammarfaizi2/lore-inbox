Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWJKUNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWJKUNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWJKUNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:13:22 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:3718 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161204AbWJKUNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:13:21 -0400
Date: Wed, 11 Oct 2006 15:13:17 -0500
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Olof Johansson <olof@lixom.net>,
       Bryce Harrington <bryce@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Potential fix for fdtable badness.
Message-ID: <20061011201317.GV4381@austin.ibm.com>
References: <200610101908.18442.vlobanov@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610101908.18442.vlobanov@speakeasy.net>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 07:08:18PM -0700, Vadim Lobanov wrote:
> 
> Dave, Olof, Linas, Bryce,
> 
> Could you please test the patch at the bottom of the email to see if it makes
> your computers happy again, if you have the time and inclination to do so?
> 
> +++ new/fs/file.c	2006-10-10 19:01:03.000000000 -0700
> -	nr++;
>  	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
> -	nr = roundup_pow_of_two(nr);
> +	nr = roundup_pow_of_two(nr + 1);

This fixed things for me!

--linas
