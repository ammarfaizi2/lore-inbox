Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWBVUrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWBVUrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWBVUrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:47:24 -0500
Received: from hierophant.serpentine.com ([66.92.13.71]:41897 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1751428AbWBVUrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:47:23 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
In-Reply-To: <20060222154820.GJ16648@ca-server1.us.oracle.com>
References: <1140383653.11403.8.camel@localhost>
	 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
	 <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org>
	 <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org>
	 <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
	 <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	 <20060222112158.GB26268@thunk.org>
	 <20060222154820.GJ16648@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 12:47:31 -0800
Message-Id: <1140641251.9011.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 07:48 -0800, Joel Becker wrote:

> 	Do you mean that you are using a distro (eg, RHEL4 or something)
> with a mainline kernel?  We've seen something similar, and what we've
> determined is happening is that insmod is returning before the module is
> done initializing.

Yep, we've seen this with other SCSI drivers.  Our solution was to add a
"sleep 15" after each modprobe in the initrd, since SCSI drivers often
take a while to pull their thumbs out.

	<b

