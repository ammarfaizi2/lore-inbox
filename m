Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUEQTxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUEQTxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUEQTxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:53:54 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:55936
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262634AbUEQTwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:52:50 -0400
From: Rob Landley <rob@landley.net>
To: Pavel Machek <pavel@ucw.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Date: Wed, 12 May 2004 15:29:24 -0500
User-Agent: KMail/1.5.4
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua> <20040509215351.GA15307@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040509215351.GA15307@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121529.26883.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 May 2004 16:53, Pavel Machek wrote:

> > I don't know how to handle this now. Introducing cow-inode number
> > with semantic "cowino1==cowino2 => files are cowlinked" is
> > ugly and won't deal with per-block cow. Sooner or later someone
> > will want to have per block cow. Think about cow'ing multi-gigabyte
> > database files for checkpointing/backup purposes...
>
> Well, if only block 17 is cowlink-shared between two files, I guess
> userspace does not want to know... And I think that cow-inode number
> *can* handle all other cases.

I remember somebody had a toy to find out the file block ranges (on ext2/ext3 
anyway), which could detect fragmentation and holes and such.  Presumably, 
whatever they did would already detect per-block cowlinks, if anybody 
actually cared...

Rob


