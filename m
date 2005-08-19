Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932756AbVHSXjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbVHSXjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVHSXjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:39:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54197 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965184AbVHSXjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:39:42 -0400
Subject: Re: dying disk results in unusable system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508181535450.20705@twinlark.arctic.org>
References: <Pine.LNX.4.63.0508181535450.20705@twinlark.arctic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Aug 2005 19:11:42 +0100
Message-Id: <1124475102.32050.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-18 at 17:31 -0700, dean gaudet wrote:
> thoughts?  i'm going to hang onto this bad disk so i can try out patches...
> if folks point me in the right direction(s) i could even work on fixes.

One problem at least is that unlike SCSI the IDE layer never gives up on
a device. That combined with a slow, polling heavy recovery process and
the fact master and slave can't be addressed together in IDE hoses stuff
pretty badly.

Alan
