Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271751AbRIJVW5>; Mon, 10 Sep 2001 17:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271747AbRIJVWq>; Mon, 10 Sep 2001 17:22:46 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:61946 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S271741AbRIJVWg>; Mon, 10 Sep 2001 17:22:36 -0400
Date: Mon, 10 Sep 2001 22:22:43 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010910222243.B9166@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0109090909001.21049-100000@duckman.distro.conectiva> <Pine.LNX.4.33.0109091105380.14479-100000@penguin.transmeta.com> <9ngirh$jsu$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9ngirh$jsu$1@cesium.transmeta.com>; from hpa@zytor.com on Sun, Sep 09, 2001 at 01:18:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 09, 2001 at 01:18:57PM -0700, H. Peter Anvin wrote:

> The ideal way to run backups I have found is on filesystems which
> support atomic snapshots -- that way, your backup set becomes not only
> safe (since it goes through the kernel etc. etc.) but totally
> coherent, since it is guaranteed to be unchanging.  This is a major
> win for filesystems which can do atomic snapshots, and I'd highly
> encourage filesystem developers to consider this feature.

It's already done.  LVM's snapshot facility has the ability to ask the
filesystem to quiesce itself into a consistent state before the
snapshot is taken, and both Reiserfs and ext3 support that function.

Cheers,
 Stephen
