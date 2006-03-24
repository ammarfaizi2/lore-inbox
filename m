Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422720AbWCXMVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWCXMVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWCXMVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:21:10 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:43690 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1422720AbWCXMVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:21:09 -0500
In-Reply-To: <200603240946.51793.arnd@arndb.de>
References: <1143178947.4257.78.camel@localhost.localdomain> <20060324062624.GA16815@pb15.lixom.net> <1143187298.3710.3.camel@localhost.localdomain> <200603240946.51793.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <54442245-B303-41F9-9E99-D8B6386B34C2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       cbe-oss-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Kill machine numbers
Date: Fri, 24 Mar 2006 13:23:32 +0100
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One thing I have been wondering about is what should be the right way
> to check whether we're running on something based on the
> Cell Broadband Engine Architecture, if that is needed somewhere.
> My original idea was to make this the platform number, but this
> seems impractical now.

Just check the PVR?  Either directly, or in the device tree.
It's not likely that there will be a million different CBEA
compliant CPUs any time soon ;-)

There really should be some other OF property in the CPU nodes
that tells us the CPU is CBEA, but I don't think we have one
right now :-(


Segher

