Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWEQNkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWEQNkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWEQNkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:40:05 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:61395 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750828AbWEQNkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:40:04 -0400
Date: Wed, 17 May 2006 09:40:03 -0400
To: Jan Wagner <jwagner@kurp.hut.fi>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
Message-ID: <20060517134003.GE23933@csclub.uwaterloo.ca>
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com> <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 11:30:55AM +0300, Jan Wagner wrote:
> Maybe yes, that, or hdparm, but it seems like a horrible hack :) And sg
> being for generic SCSI, I'm not sure how well ATA-7 fits in. At least,
> the current debian sg-tools, and commands like 'sg_opcodes /dev/sda'
> return "Fixed format, current;  Sense key: Illegal Request", "Additional
> sense: Invalid command operation code" for those SATA disks I tried.
> Doesn't look good for sg useability, AFAICT.

Just because sgtools doesn't work with it doesn't mean there aren't
commands you can send through sg to work with it.

> To record or play back real-time continuous streamed data that is not
> error-critical but delay critical, from/to a bidirectional data
> aquisition card at ~1Gbit/s over longer time spans.

Do you know of a disk that can handle 1Gbit/s to the platter?  Or are
you planning to stripe this across multiple disks?

I would think a controller on a fast enough bus (plain PCI isn't going
to handle it), with enough drives in a raid setup of the right type
should probably handle it.  Might need to do a filesystem specially
designed for the streaming needs rather than general purpose file
storage.

> Direct kernel device support for the feature set could also be very useful
> for linux projects like the Digital Video Recorder and Video Disk
> Recorder. And seek/stutter free video playback from DVD/ATAPI (scratched
> disks, for example) or video editing. Etc.

Can you tell a DVD drive to stop retrying?  Perhaps you can.  I know
some of the retries are in software.

Len Sorensen
