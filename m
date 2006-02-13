Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWBMTzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWBMTzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWBMTzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:55:51 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:9988 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S964837AbWBMTzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:55:50 -0500
Date: Mon, 13 Feb 2006 20:55:50 +0100
From: iSteve <isteve@rulez.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060213205550.6aa60142@silver>
In-Reply-To: <43F0E1EC.4050804@cfl.rr.com>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
	<m3bqxd999u.fsf@telia.com>
	<20060211170813.3fb47a03@silver>
	<43EE446C.8010402@cfl.rr.com>
	<20060211211440.3b9a4bf9@silver>
	<43EE8B20.7000602@cfl.rr.com>
	<2006021 <20060213185112.79da8ecc@silver>
	<43F0E1EC.4050804@cfl.rr.com>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 14:45:48 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:

> Hrm... the format appears to be failing with a seek error.  My guess as 
> to the cause of this is either bad media or a bad drive.  Are you sure 
> this drive can handle 80 min / 700 MB disks?

Yes, I'm very positive about it. This is Plextor Premium; it certainly can
handle 700, 800 and even larger (99m/1.2GiB) CDs, I'm burning my backups on it
on regular basis, too. I'll try to grab a few more CD-RWs tomorrow.

> I'm not sure this switch does what I think it does because I don't have 
> the source code in front of me, but after blanking try:
> 
> cdrwtool -m 259808
> 
> If that did what I think it does, it should attempt to format the disc, 
> but not all of it.  If the drive just doesn't like the outer edges, that 
> might work. 

Nope:

# cdrwtool -d /dev/cdrw -m 259808
using device /dev/cdrw
formatting 259808 blocks
4690KB internal buffer
setting write speed to 12x
wait_cmd: Input/output error
Command failed: 04 17 00 00 00 00 00 00 00 00 00 00 - sense 05.64.00
format disc: Illegal seek


-- 
 -- iSteve
