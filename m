Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262991AbTCLDGs>; Tue, 11 Mar 2003 22:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262993AbTCLDGs>; Tue, 11 Mar 2003 22:06:48 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:39050
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S262991AbTCLDGr>; Tue, 11 Mar 2003 22:06:47 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: bio too big device
Date: Tue, 11 Mar 2003 21:17:30 -0600
User-Agent: KMail/1.5
References: <200303112055.31854.scott-kernel@thomasons.org>
In-Reply-To: <200303112055.31854.scott-kernel@thomasons.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303112117.30926.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a little more digging in drivers/block/ll_rw_blk.c, it 
seems that Jens might be the best person to discuss the 
following with.

Apparently I have a system that is making bio requests of a size 
that exceeds the max sector size for the device? How is that 
possible, and more to the point, how can I help get it fixed? 

Or am I misinterpreting something?
---scott

On Tuesday 11 March 2003 08:55 pm, scott thomason wrote:
> I frequently receive this message in my syslog, apparently
> whenever there are periods of significant write activity:
>
>     bio too big device ide0(3,7) (256 > 255)
>     bio too big device ide1(22,6) (256 > 255)
>
> It's worth noting that on this system I have had ongoing
> trouble with system stability during write activity as well,
> using a wide variety of 2.5.x kernels, even though at the time
> of this symptom things are apparently running fine.
>
> Filesystems are all ext3 on top soft raid0 devices. This
> happens to be 2.5.64, but it has been happening for at least
> the last 5-6 versions.
>
> Ideas? Any further debugging output I can provide?
> ---scott
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to
> majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html Please read the FAQ
> at  http://www.tux.org/lkml/

