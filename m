Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269256AbUHZRi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269256AbUHZRi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbUHZRe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:34:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:5080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269256AbUHZRZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:25:03 -0400
Date: Thu, 26 Aug 2004 10:20:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Rik van Riel wrote:
>
> On Thu, 26 Aug 2004, Diego Calleja wrote:
> 
> > All this looks like reinventing the file/directory concept wheel.
> > Instead of adding support for streams and "use files as directories",
> > why not orientate it to "use directories as files? Streams could very
> > well be provided by directories containing files,
> 
> So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?

No no. The stream you get from a directory is totally _independent_ of the 
contents of the directory. Anything else would be pointless.

		Linus
