Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUCGEbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 23:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUCGEbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 23:31:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:17107 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261753AbUCGEbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 23:31:11 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Sun, 7 Mar 2004 15:30:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16458.42370.917655.953328@notabene.cse.unsw.edu.au>
Cc: "Ramy M. Hassan" <ramy@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: Advanced storage management ( suggestion )
In-Reply-To: message from Mike Fedyk on Saturday March 6
References: <003801c402ea$44437190$ba10a8c0@ramy>
	<404A9835.4020602@matchmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday March 6, mfedyk@matchmail.com wrote:
> 
> > 2- Support for multi-disk/multi-host storage pool.
> 
> You're mixing layers here.  MD and DM already work in this area.
> 

I would probably disagree here.
I think it makes much more sense for a filesystem to know about
multiple devices than for MD or DM to combine a bunch of devices into
the illusion of one big device, only to have the filesystem chop that
big device into little files....

(Note that I wouldn't expect a filesystem to include raid5 style
behaviour, and probably wouldn't expect raid1 like behaviour, but
having the filesystem do striping and inter-device migration itself
seems eminently sensible.)

However I don't see much value if the suggestion of a new layer that
provide lots of services of filesystems.  I strongly suspect that no
filesystem would want to use them.  Look at "jdb".  It is designed to
provide a journalling layer for any filesystem, but how many
filesystems use it?  Just one - ext3 - the one it was designed for.

NeilBrown
