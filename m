Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTBJWf5>; Mon, 10 Feb 2003 17:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbTBJWf5>; Mon, 10 Feb 2003 17:35:57 -0500
Received: from pc-80-195-34-144-ed.blueyonder.co.uk ([80.195.34.144]:64649
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S265603AbTBJWfz>; Mon, 10 Feb 2003 17:35:55 -0500
Subject: Re: [Ext2-devel] Re: fsck out of memory
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Stephan van Hienen <raid@a2000.nu>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       "Theodore Ts'o" <tytso@mit.edu>, peter@chubb.wattle.id.au, tbm@a2000.nu
In-Reply-To: <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
	<Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu>
	<20030207102858.P18636@schatzie.adilger.int> 
	<Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11james) 
Date: 10 Feb 2003 22:44:20 +0000
Message-Id: <1044917060.11838.108.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2003-02-09 at 10:08, Stephan van Hienen wrote:

> Feb  7 04:18:15 storage kernel: EXT3-fs error (device md(9,0)):
> ext3_new_block:
> Allocating block in system zone - block = 536875638

That looks like it could be a block wrap, amongst other possible causes.

> makes me wonder if this can have todo with the lbd (to allow 2TB+ devices)
> patch ? or is this something else?

Well, that's the most likely candidate, because it's the least tested
component.  Are you using Ben LaHaise's LBD fixes for the md devices? 
Without those, md and lvm are not LBD-safe.

Cheers,
 Stephen

