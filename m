Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbSKMAgQ>; Tue, 12 Nov 2002 19:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267069AbSKMAgQ>; Tue, 12 Nov 2002 19:36:16 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:24331 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267068AbSKMAgP>; Tue, 12 Nov 2002 19:36:15 -0500
Date: Wed, 13 Nov 2002 00:43:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Linux v2.5.47
Message-ID: <20021113004304.A1196@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com> <20021113002222.B323@infradead.org> <1037149432.10083.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1037149432.10083.32.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 13, 2002 at 01:03:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 01:03:52AM +0000, Alan Cox wrote:
> Very very nice. One question - what are the rules for the
> scsi_remove_host callback with regards to a hotplug ? 

The general rule so far is:  don't do hotplug - scsi code, especially
list handling, is racy as hell.  I'm not sure whether we'll have it
properly locked down and refcounted by 2.6, it's a lot of work left.

