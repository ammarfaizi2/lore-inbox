Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130519AbRCWLTa>; Fri, 23 Mar 2001 06:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRCWLTU>; Fri, 23 Mar 2001 06:19:20 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:17167 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130519AbRCWLTN>;
	Fri, 23 Mar 2001 06:19:13 -0500
Date: Fri, 23 Mar 2001 12:18:24 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Amit D Chaudhary <amit@muppetlabs.com>
Cc: lermen@fgan.de, linux-kernel@vger.kernel.org
Subject: Re: /linuxrc query
Message-ID: <20010323121824.R3932@almesberger.net>
In-Reply-To: <3ABAEED2.6020708@muppetlabs.com> <20010323075107.Q3932@almesberger.net> <3ABAF49B.9080109@muppetlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ABAF49B.9080109@muppetlabs.com>; from amit@muppetlabs.com on Thu, Mar 22, 2001 at 11:00:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit D Chaudhary wrote:
> So, it is not a requirement currently but it is useful to have the script not 
> dependent on the current pivot_root implementation.

Yes. Also note that the relative path for  dev/console  works in
either case, while /dev/console would fail without the implied
chroot in pivot_root.

> But other information in the 
> initrd.txt mentions otherwise, hence the query here.

Hmm, sounds like a bug. Where did you find this ?

> I am assuming umount and thereby blockdev after pivot_script and before
> "chroot . init ..." don't make sense as files(dev/console among others)
> are\might still be in use.

Exactly. They's in use in any case until you close and re-open the
console.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
