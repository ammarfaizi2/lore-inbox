Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUANM1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 07:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUANM1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 07:27:51 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:19828 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266131AbUANM1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 07:27:49 -0500
Date: Wed, 14 Jan 2004 23:27:42 +1100
From: Greg Banks <gnb@sgi.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS][2.4][ReiserFS] NFS and `nohide' vs. reiserfs
Message-ID: <20040114122742.GC9651@sgi.com>
References: <87eku3u6pq.wl@canopus.ns.zel.ru> <1074014378.1526.53.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1074014378.1526.53.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 12:19:38PM -0500, Trond Myklebust wrote:
> På ty , 13/01/2004 klokka 11:57, skreiv Samium Gromoff:
> > Participants:
> > 
> > - a 2.4.18 server exporting with a `nohide' option a reiserfs filesystem A
> > with a reiserfs filesystem B mounted in it.
> > 
> 
> Mind showing us your /etc/exports? I'll bet you have the "nohide" option
> set on the wrong entry.
> 
> "nohide" should set be on the /etc/exports entry for "B" if the latter
> is mounted inside "A". It does not have to be set on the entry for "A".

The other gotcha is that the export entry must specify the client
hostname explicitly, not with a * wildcard.

BTW I have a patch to fix this which I haven't submitted to Neil yet.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
