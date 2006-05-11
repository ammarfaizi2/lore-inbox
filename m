Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWEKL5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWEKL5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWEKL5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:57:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:39659 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750739AbWEKL5v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:57:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hWlDr3Vyd7Y4pQrISopRbzHFwLqclVfS1o3zGHFr0B2QawIrki4+TGAQJBv9bLP2Ef9+u072C4CcXNkX+kDXfDNAG7jEg/i62N62uuEnaMuFgBBHLYiuSDHLnbnsAFk31+fjNpvRbliqnGVVMFK+lewA7UlemnqogBUtcBjv92Y=
Date: Thu, 11 May 2006 13:56:47 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Update/kill Documentation/sysctl/* docs?
Message-Id: <20060511135647.973d339e.diegocg@gmail.com>
In-Reply-To: <20060510233728.5c27cc43.akpm@osdl.org>
References: <20060509004837.d542d2d8.diegocg@gmail.com>
	<20060510233728.5c27cc43.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 10 May 2006 23:37:28 -0700,
Andrew Morton <akpm@osdl.org> escribió:

> I'd have thought that keeping everything in Documentation/sysctl/*.txt and
> killing proc.txt would be the best approach?
> 
> But I haven't looked into it much.  You have - what approach are you
> recommending?

Well, filesystems/proc.txt is somewhat more updated than sysctl/* - 2.4
vs 2.2 (sic) (and some small 2.6 updates spread in both places). However,
filesystems/* should only contain IMO docs about the filesystem themselves
not about the data in the filesystems, and proc.txt only documents
sysctls, nothing else.

So I guess the Right Thing would be to move proc.txt to
Documentation/sysctl, and use e-violence to make people update the
non-documented parts ;) (And apparently there's more sysctl stuff lost
in the noise like networking/ip-sysctl.txt, etc)

I'll try to move everything to sysctl/ and will post a RFC about it.

(Wouldn't have sense to have a Documentation/sysfs directory documenting
the sysfs interfaces aswell?)
