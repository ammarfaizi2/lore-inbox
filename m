Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbTFRIeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbTFRIeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:34:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39850 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265108AbTFRIeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:34:11 -0400
Date: Wed, 18 Jun 2003 09:48:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       David Howells <dhowells@cambridge.redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFS autmounter support
Message-ID: <20030618084807.GC6754@parcelfarce.linux.theplanet.co.uk>
References: <3EEF5BA6.9030505@zytor.com> <18943.1055925426@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18943.1055925426@warthog.warthog>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 09:37:06AM +0100, David Howells wrote:
 
> One thing I can't do is a tree unmount, but then we can't do that anyway:
> 
> 	[root@host135 root]# df /home
> 	Filesystem           1k-blocks      Used Available Use% Mounted on
> 	automount(pid902)            0         0         0   -  /home
> 	[root@host135 root]# ls /home/
> 	[root@host135 root]# ls /home/dhowells/
> 	...
> 	[root@host135 root]# ls /home/
> 	dhowells
> 	[root@host135 root]# umount /home
> 	umount: /home: device is busy

Yes, we can.  umount -l /home and there you go.  RTFM.
