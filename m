Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSHaFSl>; Sat, 31 Aug 2002 01:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSHaFSl>; Sat, 31 Aug 2002 01:18:41 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:48900 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316199AbSHaFRx>;
	Sat, 31 Aug 2002 01:17:53 -0400
Date: Fri, 30 Aug 2002 22:21:14 -0700
From: Greg KH <greg@kroah.com>
To: Gabor Kerenyi <wom@tateyama.hu>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
Subject: Re: extended file permissions based on LSM
Message-ID: <20020831052114.GA12082@kroah.com>
References: <200208310616.04709.wom@tateyama.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208310616.04709.wom@tateyama.hu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 06:16:04AM +0200, Gabor Kerenyi wrote:
> 
> In this case we could have some very interesting (useful
> or not who knows) features. For example if there are two
> hardlinks for an inode in two different directories, the user
> could get different rights for the file depending on the
> path he reaches it.

I think you can already do this with the existing LSM interface, you can
always get the dentry for a given inode, right?  I think there might be
a problem in determining the "real" path structure of the dentry all the
time due to mount locations, but that will be fixed up by the time 2.6
is out.

> To be honest I'd welcome if the whole file permisssion
> part were moved to LSM. It would allow us to override the
> currently implemented default behavior easily.

No!  One of the main goals of the LSM design was to not override the
current Linux permission behavior.  It can only deny access to things,
not be a permissive system of allowing access to things that the current
system denies.  See the many threads on the LSM mailing list for the
reasons behind this.

thanks,

greg k-h
