Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUG1VD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUG1VD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUG1VD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:03:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:45210 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263775AbUG1VCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:02:40 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com,
       fastboot@osdl.org, mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jbarnes@engr.sgi.com
In-Reply-To: <20040728133337.06eb0fca.akpm@osdl.org>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <20040725235705.57b804cc.akpm@osdl.org>
	 <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	 <200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	 <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	 <20040728133337.06eb0fca.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091044742.31698.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 20:59:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-07-28 at 21:33, Andrew Morton wrote:
> We really don't want to be calling driver shutdown functions from a crashed
> kernel.

Then at the very least you need to disable bus mastering and have
specialist recovery functions for problematic devices. The bus
mastering one is essential otherwise bus masters will continue to
DMA random data into your new universe.

Other stuff like graphics cards and IDE may need care too.

