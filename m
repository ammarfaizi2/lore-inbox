Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbVKIWsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVKIWsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVKIWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:48:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:38808 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161012AbVKIWsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:48:24 -0500
Date: Wed, 9 Nov 2005 14:46:37 -0800
From: Greg KH <gregkh@suse.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       karim@opersys.com
Subject: Re: [PATCH 4/4] relayfs: Documentation for exported relay fileops
Message-ID: <20051109224637.GA9794@suse.de>
References: <17266.28537.722390.913812@tut.ibm.com> <20051109140336.2d584067.akpm@osdl.org> <17266.31257.240080.519064@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17266.31257.240080.519064@tut.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 04:37:13PM -0600, Tom Zanussi wrote:
> Andrew Morton writes:
>  > Tom Zanussi <zanussi@us.ibm.com> wrote:
>  > >
>  > > +By default of course, relay_open() creates relay files in the relayfs
>  > >  +filesystem.  Because relay_file_operations is exported, however, it's
>  > >  +also possible to create and use relay files in other pseudo-filesytems
>  > >  +such as debugfs.
>  > 
>  > Why would anyone wish to place relayfs files within other
> filesystems?
> 
> The reason they're exported is that when relayfs was being considered
> for inclusion, GregKH requested that the relay file operations be
> exported, which I did but didn't actually try to use them there until
> now.  It turns out that the current patch's changes are needed in
> order to be able to do that.  The reason behind being able to do this
> I assume is so that developers can use relay files do ad hoc tracing
> inside debugfs rather than have part of their application in debugfs
> and another part in relayfs.  Maybe Greg can chime in as to whether he
> thinks it's still useful

Yes, I still think that is very useful to have.  The relayfs core code
shouldn't rely on what filesystem is is placed into.

Thanks for doing this, I appreciate it.

greg k-h
