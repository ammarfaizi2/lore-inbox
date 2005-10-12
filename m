Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVJLQNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVJLQNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVJLQNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:13:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932396AbVJLQNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:13:23 -0400
Date: Wed, 12 Oct 2005 11:12:56 -0500
From: David Teigland <teigland@redhat.com>
To: Jan Hudec <bulb@ucw.cz>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051012161256.GA9058@redhat.com>
References: <20051010171052.GL22483@redhat.com> <20051010213748.GQ7992@ftp.linux.org.uk> <20051011213811.GA15913@redhat.com> <20051012084323.GC21612@djinn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012084323.GC21612@djinn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 10:43:24AM +0200, Jan Hudec wrote:
> They are normal directories and normal files, except they are not
> exposed in the mount-point, right? Then why don't you simply provide a
> directory handle for the master directory and use normal filesystem
> operations for the rest?
> 
> That way you would have just one ioctl -- getmasterdir. The tool would
> fchdir to the handle returned and manipulate the files from there with
> normal syscalls. It would still see to the user-visible part throught
> the root directory too (since bind mounts are supported, this should not
> be a problem).

That sounds nice, we'll give it a try.

> Well, if you get rid of the access to files in the master directory by
> making that directory visible somehow, you will be left with a bunch of
> ioctls on files, which are different enough to warrant individual ioctl
> numbers for sake of efficiency.

Sure, that may well be saner when we get the ioctl command set further
reduced.

Thanks,
Dave

