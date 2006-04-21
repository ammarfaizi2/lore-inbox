Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWDUOz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWDUOz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWDUOz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:55:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54765 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932333AbWDUOz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:55:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Date: Fri, 21 Apr 2006 16:55:46 +0200
User-Agent: KMail/1.9.1
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@gmail.com
References: <OF88396E73.9225D435-ON42257157.004BB28F-42257157.004C9411@de.ibm.com>
In-Reply-To: <OF88396E73.9225D435-ON42257157.004BB28F-42257157.004C9411@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604211655.46993.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 15:56, Michael Holzheu wrote:
> > This filesystem makes no sense for anything but s390 so please put it
> > under arch/s390/ (following the convention set by cell specific
> > spufs). Thanks.
> 
> Agreed! As long as the filesystem is s390 specifc, we probably should put
> it put it under arch/s390/hypfs. But in general one could imagine, that
> also other hypervisor platforms want to have such a filesystem in the
> future. In that case, we could make the filesystem more generic. E.g. we
> could split it into the filesystem part and an architecture specific
> backend which provides the hypervisor data. But you are right, until no
> other platform supports it, we should keep it simple, leave it s390
> specific and move it to arch/s390.
> 
There was some discussion about a sysfs hierarchy for hypervisor data
some time ago, see also http://lwn.net/Articles/176365/.
The idea was rather similar, just for other attributes. Maybe this
can be consolidated in some way.

Is there a strong reason why you made your own file system instead of
using subsystem_register to add /sys/hypervisor?

	Arnd <><
