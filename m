Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289002AbSANUGO>; Mon, 14 Jan 2002 15:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSANUE6>; Mon, 14 Jan 2002 15:04:58 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:10150 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288974AbSANUD1>; Mon, 14 Jan 2002 15:03:27 -0500
Subject: Re: FC & MULTIPATH !? (any hope?)
From: Brian Beattie <alchemy@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Mario Mikocevic <mozgy@hinet.hr>, Lars Marowsky-Bree <lmb@suse.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200201141524.g0EFOqj09542@localhost.localdomain>
In-Reply-To: <200201141524.g0EFOqj09542@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 14 Jan 2002 11:53:07 -0800
Message-Id: <1011037987.918.0.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 07:24, James Bottomley wrote:
> > > is there any hope of working combination of MULTIPATH with FC !?
> >
> > Yes. QLogic's newest 2200 HBA can do that. I don't know whether that is a
> > possible solution for your problem though.
> 
> To clarify: This solution is being pushed by IBM.  Unless you have a FASt 
> array, you may not get help making it work from either IBM or Qlogic.  You 
> also need the 5.x qlogic driver which you can download from the IBM website 
> (or from SuSE 7.3).
> 
> > At the moment I am using raid option multipath but it's one way
> > street, when one FC connection dies it successfully switches onto
> > another FC connection but when that second dies aswell, mount point is
> > in a limbo, no switching back to first FC connection.
> 
> I've tested the qlogic and it will switch to the secondary and back again on a 
> FASt 200 HA.
> 
> Although it was designed to work with the LSI Symplicity-4 AVT technology 
> (which is what IBM FASt's OEM), there's a high degree of probability that it 
> will also work with any array that the MD multipath driver also works for, so 
> good luck.
> 

I've been working with the multipath code.  Trying to add functionality
to it.  While I have not yet looked at this particular issue, if there
is interest I would be willing to see what can be done.  I do not think
it would be a big deal to add the functionality to reactivate a dead
path.  It should not be too hard to attempt to do so automatically.


