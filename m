Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSHDMgI>; Sun, 4 Aug 2002 08:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSHDMgI>; Sun, 4 Aug 2002 08:36:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35063 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315779AbSHDMgI>; Sun, 4 Aug 2002 08:36:08 -0400
Subject: Re: latency while writing to pc-card disks/tapes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Julian Bradfield <jcb@dcs.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15693.2431.358745.864511@toolo.dcs.ed.ac.uk>
References: <15693.2431.358745.864511@toolo.dcs.ed.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 14:57:25 +0100
Message-Id: <1028469445.14195.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another thing that surprises me is that this runs the CPU at
> full stretch, since the fan comes on. I find it hard to believe that
> writing to a rather slow tape drive can fully exercise a 1GHz
> processor continuously.
> (It may be relevant for the tape that scsi dis/reconnect is disabled,
> as it doesn't work for my card.)

PCMCIA is PIO only. Your processor is hard at work sitting waiting for
out instructions to complete across the low speed (8Mhz or so) PCMCIA
bus. Cardbus might help immensely if there are suitable cardbus adapters
around because a cardbus slot with a cardbus card (not a pcmica card) in
it is basically pure PCI


