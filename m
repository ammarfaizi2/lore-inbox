Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTEKOGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTEKOGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:06:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:19984 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261373AbTEKOGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:06:30 -0400
Date: Sun, 11 May 2003 16:22:24 +0200
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lilo and 2.5.69?
Message-ID: <20030511142224.GA16287@hh.idb.hist.no>
References: <20030511130945.GA10607@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511130945.GA10607@ulima.unil.ch>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 03:09:45PM +0200, Gregoire Favre wrote:
> Hello,
> 
> Normally I have in my lili.conf:
> 
> append = "root=/dev/scsi/host0/bus0/target15/lun0/part2 video=matrox:1600x1200-16@75"
> 
> But I got:
> 
> Fatal: open /dev/ide/host0/bus0/target0/lun0/par: No such file or
> directory
> Exit 1
> 
> Same if I put:
> root=/dev/scsi/host0/bus0/target15/lun0/part2
> 
> Or root=/dev/sdb2
> 
> Is there something special to do with this new kernel?

Looks like a bug that truncates long device names.
Looks like your'e using devfs, using
/dev/discs/discX/part2
is a fine workaround - because it is short enough.
Replace the X with whatever number your
host0-target15 disk has.

Helge Hafting
