Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUCOMTx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUCOMTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:19:52 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:57037 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262547AbUCOMTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:19:51 -0500
Date: Mon, 15 Mar 2004 13:19:34 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Carsten Otte <cotte@freenet.de>
Cc: linux-kernel@vger.kernel.org, mszeredi@inf.bme.hu, herbert@13thfloor.at
Subject: Re: unionfs
Message-ID: <20040315121934.GB16615@wohnheim.fh-wedel.de>
References: <200403151235.25877.cotte@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403151235.25877.cotte@freenet.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 March 2004 12:35:25 +0100, Carsten Otte wrote:
> Herbert Poetzl wrote:
> >FWIW, have a look at http://vserver.13thfloor.at/TBVFS
> I do really think this problem needs to be solved a different way: BSD-style 
> union mount in VFS, no redirecting filesystem.
> I am planning to work on that during the 2.7. series. I do hope I will be able 
> to write code clean enough for inclusion, lets see...

You could also have some sort of 'hidden symlink', i.e. something that
behaves just like a file but is in fact a link to some other
filesystem.  If that other filesystem is not accessable, all
operations return -EIO.

Not sure if this is a sane solution, but it would make my cow-stuff
work across filesystems as well.

Jörn

-- 
Schrödinger's cat is <BLINK>not</BLINK> dead.
-- Illiad
