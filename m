Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTIJKy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTIJKy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:54:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40890 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261921AbTIJKy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:54:26 -0400
Date: Wed, 10 Sep 2003 12:54:22 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910125422.D9878@devserv.devel.redhat.com>
References: <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com> <20030910103752.GC21313@mail.jlokier.co.uk> <20030910124151.C9878@devserv.devel.redhat.com> <02bc01c37789$ebfa9a40$5aaf7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02bc01c37789$ebfa9a40$5aaf7450@wssupremo>; from luca.veraldi@katamail.com on Wed, Sep 10, 2003 at 12:54:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 12:54:32PM +0200, Luca Veraldi wrote:
> > Memory is sort of starting to be like disk IO in this regard.
> 
> Good. So the less you copy memory all around, the better you permorm.

Actually it's "the less discontiguos memory you touch the better you
perform". Just like a 128Kb read is about the same cost as a 4Kb
disk read, the same is starting to become true for memory copies. So
in the extreme the memory copy is one operation only.
