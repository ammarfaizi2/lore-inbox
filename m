Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUDQIWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUDQIWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:22:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11940 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263743AbUDQIWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:22:07 -0400
Date: Sat, 17 Apr 2004 09:22:06 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk> <40807466.1020701@pobox.com> <20040417090712.B11481@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417090712.B11481@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 09:07:12AM +0100, Russell King wrote:
> What about other bus types?  Do I really need to teach userspace about
> the relationships between all the various bus types we have on ARM and
> how to work out what these relationships are by guessing?
> 
> Please.  The symlinks are necessary and they are the sole source of
> the relationship information.

In which case you want them to be associated with target, not the current
pathname of target.  And no, I don't buy the "so far all renames happen *here*
and all symlinks are pointing *there*, so we don't care" - that won't last.

When do we have a legitimate reason for dangling symlinks in sysfs, anyway?
