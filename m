Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSIIMQI>; Mon, 9 Sep 2002 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSIIMQH>; Mon, 9 Sep 2002 08:16:07 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:31990
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317189AbSIIMQH>; Mon, 9 Sep 2002 08:16:07 -0400
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020909104944.GH27887@marowsky-bree.de>
References: <20020909104944.GH27887@marowsky-bree.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 13:23:28 +0100
Message-Id: <1031574208.29718.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 11:49, Lars Marowsky-Bree wrote:
> Or can the LVM2 device-mapper be used to do that more cleanly?
> 
> I wonder whether anyone has given this some thought already.

The md layer code can already do the job fine - but it does need to get
to the point that the block layer provides better error information
upstream so it can make better decisions.

LVM2 is a nice clean remapper, so it should sit on top of the md or
other failover mappers easily enough. You can probably do failover by
updating map tables too.

Its nice clean code unlike EVMS, and doesnt duplicate half the kernel 
so its easier to hack on

