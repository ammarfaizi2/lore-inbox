Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSANPZp>; Mon, 14 Jan 2002 10:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSANPZf>; Mon, 14 Jan 2002 10:25:35 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:43598
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286413AbSANPZU>; Mon, 14 Jan 2002 10:25:20 -0500
Message-Id: <200201141524.g0EFOqj09542@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Mario Mikocevic <mozgy@hinet.hr>
cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: FC & MULTIPATH !? (any hope?)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Jan 2002 10:24:52 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > is there any hope of working combination of MULTIPATH with FC !?
>
> Yes. QLogic's newest 2200 HBA can do that. I don't know whether that is a
> possible solution for your problem though.

To clarify: This solution is being pushed by IBM.  Unless you have a FASt 
array, you may not get help making it work from either IBM or Qlogic.  You 
also need the 5.x qlogic driver which you can download from the IBM website 
(or from SuSE 7.3).

> At the moment I am using raid option multipath but it's one way
> street, when one FC connection dies it successfully switches onto
> another FC connection but when that second dies aswell, mount point is
> in a limbo, no switching back to first FC connection.

I've tested the qlogic and it will switch to the secondary and back again on a 
FASt 200 HA.

Although it was designed to work with the LSI Symplicity-4 AVT technology 
(which is what IBM FASt's OEM), there's a high degree of probability that it 
will also work with any array that the MD multipath driver also works for, so 
good luck.

James Bottomley
SteelEye Technology


