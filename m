Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269739AbUHZWZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269739AbUHZWZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269707AbUHZWYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:24:44 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:9732 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269745AbUHZWU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:20:57 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: Rik van Riel <riel@redhat.com>
Subject: Re: silent semantic changes with reiser4
Date: Fri, 27 Aug 2004 00:20:38 +0200
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408270020.39190.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 22:10, Rik van Riel wrote:

> Do we really want to have a file paradigm that's different
> from the other OSes out there ?
>
> What happens when users want to transfer data from Linux
> to another system ?

I think it depends on the transport being used: some transports could allow 
for metadata (i.e. a MIME-compatible transport) while some others don't. Of 
course, the remote side needs to also support metadata (i,e. using a 
MIME-compatible transport against a remote host that doesn't understand 
metadata is certainly impossible).

For example, with FTP transports, I guess the only possible option is to 
transfer the unnamed/default stream. NFS should allow metadata, but this 
probably needs some kind of extensions to the NFS protocol.
