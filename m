Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264922AbRFZC4i>; Mon, 25 Jun 2001 22:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264923AbRFZC42>; Mon, 25 Jun 2001 22:56:28 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:44350 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264922AbRFZC4L>;
	Mon, 25 Jun 2001 22:56:11 -0400
Message-ID: <20010626045614.A24248@win.tue.nl>
Date: Tue, 26 Jun 2001 04:56:14 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wrong disk index in /proc/stat
In-Reply-To: <Pine.LNX.4.30.0106252133180.13052-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0106252133180.13052-100000@biker.pdb.fsc.net>; from Martin Wilck on Mon, Jun 25, 2001 at 09:40:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 09:40:56PM +0200, Martin Wilck wrote:

> no one seems to have noticed

Don't worry. The set of people who noticed was nonempty.

On the other hand, in my tree:

static inline unsigned int disk_index (kdev_t dev)
{
        struct gendisk *g = get_gendisk(dev);
        return g ? (MINOR(dev) >> g->minor_shift) : 0;
}
