Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWARTtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWARTtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWARTtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:49:22 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:62823 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932496AbWARTtW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:49:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FdlCYr9NsY3GDlBYGVAjzx2z2Gnn0wdGnxs4MGqtisTyyjruassaNT44Pbmpif5fFzChxrFRDPIoYFOl+1xvOw4oRCwwQteX8XUThi4qLvuVZ/z43LsUoV5pZOV6tVYdkPSjjDNwKKeZ6v5MMpZPpjNAHUuavh8zL/Ny+/vl5c0=
Message-ID: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com>
Date: Wed, 18 Jan 2006 13:49:21 -0600
From: Don Dupuis <dondster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Can't mlock hugetlb in 2.6.15
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an app that mlocks hugepages. The same app works just fine in 2.6.14.
This app has 128MB or more of shared memory that is using hugepages via
mmap. When I try this, I get the error "can't allocate memory".  Is this a
kernel bug or is this not supported anymore.  I want to guarantee that
this memory doesn't get swapped out to a swap device. I made the same
modifications to include/linux/resource.h that was in 2.6.14, which
set MLOCK_LIMIT to 2GB.

Thanks

Don
