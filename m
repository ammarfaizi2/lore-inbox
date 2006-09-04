Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWIDLBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWIDLBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWIDLBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:01:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:5931 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932123AbWIDLBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:01:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pNBPHvJ6qO6B6Bwmk6rU9EpGXBOCl6AegpxzdwhBlgW54Y2/jMg+kMrVu6NiNrBv3AxuscO721ZUvBM5JMBqDRZeVyai/2ZAEtf3EDw5Rh3hlocx0p9n8DpCzvcFOM31qoSz3KCbr48hsNIHqbtZNae5lxOStyCD3w/DgUK7cNk=
Message-ID: <84144f020609040401h314bdb72x4c3bd7c27cb38256@mail.gmail.com>
Date: Mon, 4 Sep 2006 14:01:41 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Stephen Rothwell" <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
In-Reply-To: <20060903194456.GA4977@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901115327.80554494.sfr@canb.auug.org.au>
	 <20060901172310.GA2622@filer.fsl.cs.sunysb.edu>
	 <Pine.LNX.4.61.0609031941210.12800@yvahk01.tjqt.qr>
	 <20060903194456.GA4977@filer.fsl.cs.sunysb.edu>
X-Google-Sender-Auth: 628272e81f931995
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/06, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> I think you misunderstood my comment. What I meant to say was that there is
> _no way_ you can compile a filesystem that has only dentry ops but not
> superblock ops - this would happen if you tried to bisect and you landed
> half way in the series of commits for the filesystem. For the _initial_
> commit one cset makes sense. For subsequent fixes one commit per fix is the
> only logical thing to do.

Reorder the patches so that Makefile and Kconfig changes come last and
git bisect will work just fine.

-- 
VGER BF report: H 0
