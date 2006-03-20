Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWCTTWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWCTTWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWCTTWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:22:55 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:7633 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965180AbWCTTWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:22:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AqBHCyGbGowkPDfoWz/Y9a7jhaPgkJ/wGWuwoEfrjpMEdB8rOKz9aayYon+hXrvGTtVgP8vwWx2paDguV5OhBI+V21XqtLCg26nTIm7QEDvhMIc4KfU+fp2vehPh/BPzdnXSY5RyW0kQaahRxHkSxdIiqZyfxssL46cmxuEVAlU=
Message-ID: <305c16960603201122t79dd93c1t484c83acf4ed191b@mail.gmail.com>
Date: Mon, 20 Mar 2006 16:22:51 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Jeff Dike" <jdike@addtoit.com>
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "Neil Brown" <neilb@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060320175633.GA5797@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17436.60328.242450.249552@cse.unsw.edu.au>
	 <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr>
	 <17438.13214.307942.212773@cse.unsw.edu.au>
	 <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr>
	 <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com>
	 <20060320175633.GA5797@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Jeff Dike <jdike@addtoit.com> wrote:
> On Mon, Mar 20, 2006 at 01:17:59PM -0300, Matheus Izvekov wrote:
> > If a filesystem is nodev, then what would you fsck? Am i missing something?
>
> There's a UML filesystem for which the nodev-implies-no-fsck behavior
> is inconvenient.  It stores its files as files on the host, where the
> file metadata is stored separately from the file data.  If the two
> fall out of sync after a crash, we need to fsck it.  In this case,
> fsck would do a hostfs mount of the data and metadata (where the files
> are available as they exist on the host) and fix things up.
>
> So, in this case, the thing being fscked is a directory hierarchy on
> the host.
>
>                                 Jeff
>

I see, i didnt know about this. But then pam_mount would need to do
special treatment for this. I imagine it has been only coded to work
in the case where there is a device to pass to fsck as a parameter.
