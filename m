Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWFGPXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWFGPXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWFGPXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:23:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:30600 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932254AbWFGPXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:23:11 -0400
From: Andi Kleen <ak@suse.de>
To: "Brendan Trotter" <btrotter@gmail.com>
Subject: Re: NMI problems with Dell SMP Xeons
Date: Wed, 7 Jun 2006 17:23:05 +0200
User-Agent: KMail/1.9.3
Cc: "Keith Owens" <kaos@sgi.com>, "Ashok Raj" <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org
References: <200606070920.23436.ak@suse.de> <8446.1149666227@kao2.melbourne.sgi.com> <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com>
In-Reply-To: <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071723.05921.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The "send_IPI_mask_sequence()" function also seems like a perfectly
> valid option (except for the comments, which are easy enough to
> change). IMHO it's just not as pretty, especially if it's to be used
> for all broadcast IPIs (rather than just for broadcast NMIs) - I'd be
> tempted to do an "#ifdef BORKED_DELL" around it in that case. :-)

It's not only that Dell that has trouble with broadcasts. On newer platforms
which support CPU hotplug there are races at the hardware level with
broadcasting. That is why we're moving away from it.

Not sure why this particular case got missed. Ashok might want to comment -
he did the hotplug work.

-Andi
