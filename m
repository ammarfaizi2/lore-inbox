Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWHDIhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWHDIhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWHDIhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:37:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44998 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161107AbWHDIhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:37:09 -0400
From: Andi Kleen <ak@suse.de>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: Futex BUG in 2.6.18rc2-git7
Date: Fri, 4 Aug 2006 10:36:47 +0200
User-Agent: KMail/1.9.3
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
References: <200608040917.00690.ak@suse.de> <20060804082637.GA19493@aepfle.de>
In-Reply-To: <20060804082637.GA19493@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041036.47763.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 August 2006 10:26, Olaf Hering wrote:
> On Fri, Aug 04, 2006 at 09:17:00AM +0200, Andi Kleen wrote:
> > 
> > One of my test machines (single socket core2 duo) running 2.6.18rc2-git7 over night 
> > under moderate load threw this, followed by an endless loop of soft lockup timeouts
> > (one exemplar appended)
> > 
> > I assume it is related to the new PI mutexes.
> 
> Maybe triggered by this, if it was from wagner.suse.de:

Yes it was that box. So it looks like the new mutex code cannot run
the glibc test suite.

-Andi

> > /usr/src/packages/BUILD/glibc-2.4/cc-nptl/nptl/tst-robustpi8.out 
> Read from remote host wagner: Connection reset by peer
> 
> 
