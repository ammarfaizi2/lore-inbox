Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUEaLoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUEaLoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUEaLoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:44:00 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59525
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263786AbUEaLn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:43:59 -0400
From: Rob Landley <rob@landley.net>
To: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: swappiness=0 makes software suspend fail.
Date: Mon, 31 May 2004 06:38:20 -0500
User-Agent: KMail/1.5.4
Cc: ncunningham@linuxmail.org, cef-lkml@optusnet.com.au,
       linux-kernel@vger.kernel.org, seife@suse.de
References: <200405280000.56742.rob@landley.net> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org>
In-Reply-To: <20040531031743.0d7566e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405310638.21015.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 May 2004 05:17, Andrew Morton wrote:
> btw, software suspend wrecks your swap partition if you suspend to swap but
> do not resume from swap - you need to run mkswap again.  Seems odd.

I think it's intentional, so that if you you boot to a different kernel swapon 
-a won't automount the swap partition and hork your saved image.

Of course, mounting/fscking any of the filesystems in question would kinda 
screw that up too, and if the swap partition's is in the other kernel's fstab 
then presumably overlapping filesystems probably are too.  (Intentional isn't 
necessarily the same thing as right... :)

Rob

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

