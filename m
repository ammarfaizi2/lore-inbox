Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTA2TgX>; Wed, 29 Jan 2003 14:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTA2TgX>; Wed, 29 Jan 2003 14:36:23 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:22504 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S266810AbTA2TgW>;
	Wed, 29 Jan 2003 14:36:22 -0500
Date: Wed, 29 Jan 2003 19:45:42 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: rwilkens@alumni.clemson.edu, vda@port.imtp.ilyichevsk.odessa.ua
Cc: Balram Adlakha <b_adlakha@softhome.net>, linux-kernel@vger.kernel.org,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: LKML I/O scheduling (was Re: Bootscreen [had to throw in 2 cents
 worth, sorry])
Message-ID: <1409571226.1043869542@[192.168.100.5]>
In-Reply-To: <1043854259.877.25.camel@RobsPC.RobertWilkens.com>
References: <1043854259.877.25.camel@RobsPC.RobertWilkens.com>
X-Mailer: Mulberry/2.2.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

--On 29 January 2003 10:31 -0500 Rob Wilkens <robw@optonline.net> wrote:

[huge snip]

> p.s. I'm hoping this thread is about the possibility of putting some
> sort of graphical bootscreen up.  I'm tuning in late, so if I'm on the
> wrong page, just ignore me.

The LKML message I/O scheduling rules suggest that if a fair number of
reads are not processed prior to write activity, then a lot of bandwidth
can be wasted and the medium can eventually become write-only due to
messsage storms. This can be avoided by ensuring writers block to allow
their read activity to progress first - the write should in general be
dependent on the reads in any case. As per Andrew Morton's post on
anticipatory scheduling, a short delay before doing the write to allow
further reads to take place is often a good idea in this context too.

--
Alex Bligh
