Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSFTXm7>; Thu, 20 Jun 2002 19:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSFTXm6>; Thu, 20 Jun 2002 19:42:58 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:32390 "EHLO gagarin")
	by vger.kernel.org with ESMTP id <S315919AbSFTXm5>;
	Thu, 20 Jun 2002 19:42:57 -0400
Date: Fri, 21 Jun 2002 01:42:52 +0200
To: Andries.Brouwer@cwi.nl
Cc: davej@suse.de, andersg@0x63.nu, linux-kernel@vger.kernel.org,
       whitney@adsl-209-76-109-63.dsl.snfc21.pacbell.net
Subject: Re: /proc/partitions broken in 2.5.23
Message-ID: <20020620234252.GA3166@h55p111.delphi.afb.lu.se>
References: <UTC200206202321.g5KNLeT22807.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200206202321.g5KNLeT22807.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 01:21:40AM +0200, Andries.Brouwer@cwi.nl wrote:
>     > I got a bug report about an issue with LVM in 2.5.22-dj1, which turns
>     > out to be caused by broken /proc/partitions in mainline.
>     > 
>     > (davej@mesh:davej)$ cat /proc/partitions 
>     > major minor  #blocks  name
>     > 
>     >    8     0          0 sda
>     >   22     0 1515870810 hdc
>     > 
>     > Note the huge numbers in hex are 0x5a5a5a5a, so something
>     > seems to be getting poisoned somewhere.
> 
> Is this LVM?
> 
> I don't see how LVM could produce such values.
> (And in fact LVM does not even compile, so only a patched LVM
> could produce anything at all.)

Me neither. And as a datapoint: with my lvm-cleanup-patch I get
correct size-values for all my partitions (but, yes, all 0-sized LVs
shows). But there is a problem with my /proc/partitions, i starts with
2 pages of garbage (8k). Is this some kind of overflow problem as lvm
creates 256 entries? 


-- 

//anders/g

