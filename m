Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbTHTQt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTHTQt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:49:57 -0400
Received: from gsd.di.uminho.pt ([193.136.20.132]:42901 "EHLO
	bbb.lsd.di.uminho.pt") by vger.kernel.org with ESMTP
	id S262047AbTHTQtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:49:51 -0400
Date: Wed, 20 Aug 2003 17:49:49 +0100
From: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, spiridonov@gamic.com
Subject: Re: how to turn off, or to clear read cache?
Message-ID: <20030820164949.GA5613@lsd.di.uminho.pt>
Mail-Followup-To: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spiridonov@gamic.com
References: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk> <3F437646.4050107@gamic.com> <yw1x8ypocv63.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x8ypocv63.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
X-Disclaimer: 'Author of this message is not responsible for any harm done to reader's computer.'
X-Organization: 'GSD'
X-Section: 'BIC'
X-Priority: '1 (Highest)'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 03:31:32PM +0200, Måns Rullgård wrote:
> Sergey Spiridonov <spiridonov@gamic.com> writes:
> 
> >>> I need to make some performance tests. I need to switch off or to
> >>> clear read cache, so that consequent reading of the same file will
> >>> take the same amount of time.
> >>>
> >>>Is there an easy way to do it, without rebuilding the kernel?
> >> Unmount and remount the filesystem.
> >
> >
> > Would
> >
> > # mount -o remount
> >
> > do the job?
> 
> no

What about dd if=/dev/hda bs=8M count=$(awk '/MemTotal/ { printf "%d", $2/4096 }' /proc/meminfo) ?

Will it clear the cache?

Regards,
Luciano Rocha
