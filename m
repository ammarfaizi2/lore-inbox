Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTIXWhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTIXWhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:37:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12524 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261500AbTIXWhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:37:00 -0400
Date: Wed, 24 Sep 2003 23:36:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, olof@austin.ibm.com
Subject: Re: [PATCH] [2.4] Re: /proc/ioports overrun patch
Message-ID: <20030924223657.GB7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva> <Pine.A41.4.44.0309241437330.22232-100000@forte.austin.ibm.com> <20030924195133.GY7665@parcelfarce.linux.theplanet.co.uk> <20030924195926.GZ7665@parcelfarce.linux.theplanet.co.uk> <20030924214713.GA7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924214713.GA7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Umm...  Linus, output truncation is 2.4 problem; any seq_file-based
variant (including one already in 2.6 and being backported to 2.4) solves
that.  The thing being, variant we had in 2.6 was ugly - it had walk through
the tree shoved into ->show() instead of having the iterator do that for
us.  And that's what this patch fixed - it's not that old 2.6 variant would
break, it's that it was done in wrong way.  IOW, changeset comment is
misleading...
