Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSIIPBZ>; Mon, 9 Sep 2002 11:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSIIPBZ>; Mon, 9 Sep 2002 11:01:25 -0400
Received: from gate.in-addr.de ([212.8.193.158]:62990 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S317349AbSIIPBX>;
	Mon, 9 Sep 2002 11:01:23 -0400
Date: Mon, 9 Sep 2002 17:06:48 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md multipath with disk missing ?
Message-ID: <20020909150648.GD29@marowsky-bree.de>
References: <20020909132713.GA29@marowsky-bree.de> <Pine.LNX.4.44.0209091537020.12771-100000@omega.s-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0209091537020.12771-100000@omega.s-tec.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-09T15:46:15,
   Oktay Akbal <oktay.akbal@s-tec.de> said:

> Example:
> 
> We have sda - sdb (8 drives) and setup up a raidtab to tell linux that
> sda and sde are the same sdc - sdd etc.
> Now for some random error the server restarts and the former sda (path to
> that drive) is no longer available. So now we have sda,sdb...sdg.
> We do not use autodetect, but raidstart to activate the raid.
> 
> now since the former sda is missing the raidtab does not reflect the
> actual setup. The raidtab would read, that sda and sdb are the same
> drive, which is not true in that case.
> 
> (The device-ordering would not be right for a real setup, but take it as
> an example and assume sda-sde sdb-sdf...)
> 
> Would the superblock prevent the wrong use of devices ?

I hope so. But yes, your setup would break spectularly because the devices
moved and the raids wouldn't go online. This shouldn't happen with the
autostart feature, I think.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

