Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282825AbRK0HEW>; Tue, 27 Nov 2001 02:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282826AbRK0HEM>; Tue, 27 Nov 2001 02:04:12 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:60421 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S282825AbRK0HEA>; Tue, 27 Nov 2001 02:04:00 -0500
Date: Tue, 27 Nov 2001 09:03:39 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Rob Landley <landley@trommello.org>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127090339.K4809@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0111261535070J.02001@localhost.localdomain>; from landley@trommello.org on Mon, Nov 26, 2001 at 03:35:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 03:35:07PM -0500, you [Rob Landley] claimed:
> 
> What kind of write-up do you want?  (How formal?)
> 

(...)
 
> That way, the power down problem is strictly limited:
> 
> 1) write out the track you're over
> 2) seek to the second track
> 3) write that out too
> 4) park the head

(...)

A stupid question. Instead of adding there electric components and smart
features to drive logic, couldn't the problem be simply be taken care of by
adding an acknowledge message to the ATA protocol (unless it already has
one)?

So _after_ the data has been 100% committed to _disk_, the disk would
acknowledge the OS. The OS wouldn't have to wait on the command (unless it
wants to -- think of write ordering barrier!), and the disk could have as
large cache as it needs. It would simply accept the write command to its
cache and send the ACKs even half a second later. The OS wouldn't consider
anything as committed to disk before its gets the ACK.

Again, I know nothing of ATA so this can be impossible to do (strict ordered
command-reply protocol?), or already implemented but not enough. Please
correct me. I must be missing something.


-- v --

v@iki.fi
