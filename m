Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTGAP2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 11:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTGAP2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 11:28:43 -0400
Received: from mail011.syd.optusnet.com.au ([210.49.20.139]:23693 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262498AbTGAP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:28:34 -0400
Date: Wed, 2 Jul 2003 01:41:33 +1000
To: "Leonard Milcin Jr." <thervoy@post.pl>
Cc: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030701154133.GB3707@cancer>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl> <3EFF4177.6000705@post.pl> <200306291548060930.02159FEE@smtp.comcast.net> <20030701101509.GC3587@cancer> <3F01A0FE.6060403@post.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F01A0FE.6060403@post.pl>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 04:55:58PM +0200, Leonard Milcin Jr. wrote:

> I think of some sort of overlay filesystem on top of that *thing*. In
> this case ovarlay filesystem could serve as redo log in database system.
> Then we need only worry with read operations, not write. Writes will be
> stored in redo log, and eventually they will be included when actual
> read only filesystem will be converted.

This is exactly what has been said before in this thread
 - i.e. mount the new FS over the old one (union style)
and new writes go to the new FS.

I really thing LVM resizing automagick would be the way to go to.
*much* cleaner and easier to implement.

The real useful thing to do would be to write a utility that would
convert non-LVM systems to LVM.

-- 
Stewart Smith
Vice President, Linux Australia
http://www.linux.org.au (personal: http://www.flamingspork.com)
