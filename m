Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTGAKCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTGAKCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:02:10 -0400
Received: from mail022.syd.optusnet.com.au ([210.49.20.149]:51410 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261919AbTGAKCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:02:08 -0400
Date: Tue, 1 Jul 2003 20:15:09 +1000
To: rmoser <mlmoser@comcast.net>
Cc: "Leonard Milcin Jr." <thervoy@post.pl>, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030701101509.GC3587@cancer>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl> <3EFF4177.6000705@post.pl> <200306291548060930.02159FEE@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291548060930.02159FEE@smtp.comcast.net>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 03:48:06PM -0400, rmoser wrote:

> Yeppers.  Also that the eventual goal (at least in  my mind) is to allow
> this to be done on a running r/w filesystem safely, which isn't as tough
> a problem as it sounds.

Yes it is. In fact, it is more of a problem then you think.

Think of this simple scenario:
a script is running that downloads a kernel patch, applies it to a tree,
then renames the directory to $1-$patchname.

Half way through this, during the patch, the backup script comes through
and starts to backup the filesystem.


Now - wipe the drive clean at the end and restore it to a sane state.

Doing live things on storage systems without transactions, snapshots or
whatever you want to call them is tricky at best. resizing is going to 
cause headaches.

-- 
Stewart Smith
Vice President, Linux Australia
http://www.linux.org.au (personal: http://www.flamingspork.com)
