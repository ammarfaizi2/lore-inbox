Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVKOA6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVKOA6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVKOA6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:58:03 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:51468 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932236AbVKOA6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:58:01 -0500
Date: Tue, 15 Nov 2005 01:58:00 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Mike Christie <mchristi@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051115005800.GA9543@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Mike Christie <mchristi@redhat.com>, linux-kernel@vger.kernel.org
References: <4378650A.1070209@drzeus.cx> <1131964282.2821.11.camel@laptopd505.fenrus.org> <20051114111108.GR3699@suse.de> <1131967167.2821.14.camel@laptopd505.fenrus.org> <20051114112402.GT3699@suse.de> <1131967678.2821.21.camel@laptopd505.fenrus.org> <20051114113442.GU3699@suse.de> <1131969212.2821.27.camel@laptopd505.fenrus.org> <20051114120417.GA33935@dspnet.fr.eu.org> <43792C82.5010707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43792C82.5010707@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 06:32:02PM -0600, Mike Christie wrote:
> If you have stack problem with iscsi then you should post it to those 
> lists or send me a pointer offlist. There were problems with iscsi and 
> XFS but they should be fixed in mainline. The XFS + iscsi problems that 
> have been reported have not been stack usage problems though.

That hasn't been very efficient last time.  In any case, on the latest
version I tried (0.4-408, I can't blow up the backup machine every
other day):

- iscsi-tape is incompatible with tg3 and works with e1000

- iscsi-disk blows after a random time in what seems to be a (irq?)
  stack explosion on x86 but not on x86-64 (which iirc has bigger
  stacks).  Seems to because the serial console blows too and only
  writes a handful of characters.

Filesystem is reiser3.

  OG.
