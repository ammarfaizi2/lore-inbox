Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbTDUJOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 05:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTDUJOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 05:14:21 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:22278 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S263790AbTDUJOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 05:14:20 -0400
Message-Id: <200304210917.h3L9HIu07472@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andreas Dilger <adilger@clusterfs.com>, John Bradford <john@grabjohn.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Date: Mon, 21 Apr 2003 12:25:28 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20030419185201.55cbaf43.skraw@ithnet.com> <200304192004.h3JK4Sgc000152@81-2-122-30.bradfords.org.uk> <20030419143325.T26054@schatzie.adilger.int>
In-Reply-To: <20030419143325.T26054@schatzie.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 April 2003 23:33, Andreas Dilger wrote:
> On Apr 19, 2003  21:04 +0100, John Bradford wrote:
> > > > > I wonder whether it would be a good idea to give the linux-fs
> > > > > (namely my preferred reiser and ext2 :-) some
> > > > > fault-tolerance.
>
> I'm not against this in principle, but in practise it is almost
> useless. Modern disk drives do bad sector remapping at write time, so
> unless something is terribly wrong you will never see a write error
> (which is exactly the time that the filesystem could do such
> remapping).  Normally, you will only see an error like this at read
> time, at which point it is too late to fix.

It is *not* useless.

I have at least 4 disks with some bad sectors. Know what?
They are still in use in a school lab and as 'big diskettes'
(transferring movies etc). I refuse to dump them just because
'todays disks are cheap'. I don't want my fs to die just because
these disks develop (ohhhh) a single new bad sector.
--
vda
