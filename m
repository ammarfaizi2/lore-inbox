Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVDCUE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVDCUE5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 16:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVDCUE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 16:04:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54206 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261886AbVDCUE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 16:04:56 -0400
Date: Sun, 3 Apr 2005 21:04:43 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: LVM general discussion and development <linux-lvm@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Antti Salmela <asalmela@iki.fi>,
       linux-kernel@vger.kernel.org, dmo@osdl.org
Subject: Re: [linux-lvm] Re: 2.6.11ac5 oops while reconstructing md array and moving volumegroup with pvmove
Message-ID: <20050403200443.GS14307@agk.surrey.redhat.com>
Mail-Followup-To: LVM general discussion and development <linux-lvm@redhat.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, Antti Salmela <asalmela@iki.fi>,
	linux-kernel@vger.kernel.org, dmo@osdl.org
References: <20050401143853.GA11763@asalmela.iki.fi> <16973.56100.413874.917027@cse.unsw.edu.au> <20050402060937.GA27664@asalmela.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402060937.GA27664@asalmela.iki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 09:09:37AM +0300, Antti Salmela wrote:
> % mdadm --create -l 1 -n 2 /dev/md2 /dev/hde /dev/hdg
> % pvcreate /dev/md2
> % vgextend vg1 /dev/md2
> % pvmove /dev/hdf /dev/md2
 
A few similar reports still appearing, possibly still related to 
the md bio_clone changes that fixed some bugs for md but 
created new ones for dm...

Would be good if you could re-test with a current 2.6.12-
I'll look into later this week if nobody beats me to it - please!

Alasdair

