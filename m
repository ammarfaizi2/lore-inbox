Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWG0DBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWG0DBB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 23:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWG0DBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 23:01:00 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:28854 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1161015AbWG0DBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 23:01:00 -0400
Date: Wed, 26 Jul 2006 20:00:58 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: adam radford <aradford@gmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
In-Reply-To: <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607261959010.4568@twinlark.arctic.org>
References: <20060710141315.GA5753@fi.muni.cz> 
 <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org> 
 <1153946249.13509.29.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org>
 <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, adam radford wrote:

> On 7/26/06, dean gaudet <dean@arctic.org> wrote:
> > 
> > unfortunately when i did the experiment i neglected to perform
> > simultaneous tests on more than one 3ware unit on the same controller.  i
> > got great results from a raid1 or from a raid10 (even a raid5)... but
> > never i only tested one unit at a time.
> > 
> 
> Did you try setting /sys/class/scsi_host/hostX/cmd_per_lun to 256 / num_units
> ?

hmm doesn't look like i can do this in 2.6.16.27:

# ls -l /sys/class/scsi_host/host0/cmd_per_lun
-r--r--r-- 1 root root 0 Jul 26 19:58 /sys/class/scsi_host/host0/cmd_per_lun
# echo 85 >!$
echo 85 >/sys/class/scsi_host/host0/cmd_per_lun
zsh: permission denied: /sys/class/scsi_host/host0/cmd_per_lun

it'll probably be sometime until i update this box past 2.6.16.x ... but 
i'll keep it in mind and retry the experiment... thanks.

-dean
