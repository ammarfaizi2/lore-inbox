Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbREABCo>; Mon, 30 Apr 2001 21:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135484AbREABCf>; Mon, 30 Apr 2001 21:02:35 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:14900 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132556AbREABCQ>; Mon, 30 Apr 2001 21:02:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Michael H. Warfield" <mhw@wittsend.com>
cc: Francois Gouget <fgouget@free.fr>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Elmer Joandi <elmer@linking.ee>, Ookhoi <ookhoi@dds.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work 
In-Reply-To: Your message of "Mon, 30 Apr 2001 18:10:56 -0400."
             <20010430181056.A10487@alcove.wittsend.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 11:00:44 +1000
Message-ID: <18097.988678844@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001 18:10:56 -0400, 
"Michael H. Warfield" <mhw@wittsend.com> wrote:
>On Mon, Apr 30, 2001 at 01:22:59PM -0700, Francois Gouget wrote:
>> Apr 30 13:19:34 oleron cardmgr[148]: initializing socket 0
>> Apr 30 13:19:34 oleron cardmgr[148]: socket 0: Aironet PC4800
>> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_core'
>> Apr 30 13:19:34 oleron cardmgr[148]: + Warning: /lib/modules/2.4.4/kernel/drivers/net/aironet4500_core.o 
>> symbol for parameter rx_queue_len not found

Bug in drivers/net/aironet4500_core.c.  It has
  MODULE_PARM(rx_queue_len,"i");
but rx_queue_len is never defined.  Only a warning.

>> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_proc'
>> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_cs'
>> Apr 30 13:19:35 oleron cardmgr[148]: get dev info on socket 0
>> failed: Resource temporarily unavailable

Separate problem, the aironet4500_cs driver could not get its
resources.

>	Seen this before.  What version are your modutils at?  Latest are
>2.4.5 on kernel.org and there have been several times where I've had
>them slip out of rev and ended up with missing symbols.

The version of modutils does not affect missing symbols, it just
reports kernel bugs.

