Return-Path: <linux-kernel-owner+w=401wt.eu-S1750748AbWLKXog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWLKXog (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWLKXog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:44:36 -0500
Received: from web32602.mail.mud.yahoo.com ([68.142.207.229]:30062 "HELO
	web32602.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750748AbWLKXog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:44:36 -0500
Message-ID: <20061211234435.37302.qmail@web32602.mail.mud.yahoo.com>
X-YMail-OSG: lVNAWqcVM1nrZIJ1xUhKGCZ6mfVIoJiI3FFI02GwDYOPvG9Bn.US0rHPJmacUDOluBamo_NnwICKZ3WVePpaov7OVUGez2As6ZtwOoKE4agv5_6II8e8og--
X-RocketYMMF: knobi.rm
Date: Mon, 11 Dec 2006 15:44:35 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: [2.6.19] NFS: server error: fileid changed
To: Trond Myklebust <trond.myklebust@fys.uio.no>, knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165857788.5721.127.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Mon, 2006-12-11 at 08:09 -0800, Martin Knoblauch wrote:
> > Hi, [please CC me, as I am not subscribed]
> > 
> >  after updating a RHEL4 box (EM64T based) to a plain 2.6.19 kernel,
> we
> > are seeing repeated occurences of the following messages (about
> every
> > 45-50 minutes).
> > 
> >  It is always the same server (a NetApp filer, mounted via the
> > user-space automounter "amd") and the expected/got numbers seem to
> > repeat.
> 
> Are you seeing it _without_ amd? The usual reason for the errors you
> see are bogus replay cache replies. For that reason, the kernel is
> usually very careful when initialising its value for the
> XID: we set part of it using the clock value, and part of it
> using a random number generator.
> I'm not so sure that other services are as careful.
>

 So far, we are only seeing it on amd-mounted filesystems, not on
static NFS mounts. Unfortunatelly, it is difficult to avoid "amd" in
our environment.
 
> >  Is there a  way to find out which files are involved? Nothing
> seems to
> > be obviously breaking, but I do not like to get my logfiles filled
> up. 
> 
> The fileid is the same as the inode number. Just convert those
> hexadecimal values into ordinary numbers, then search for them using
> 'ls
> -i'.
> 

 thanks. will check that out.

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
