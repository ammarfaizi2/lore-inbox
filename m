Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSIINVo>; Mon, 9 Sep 2002 09:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSIINVo>; Mon, 9 Sep 2002 09:21:44 -0400
Received: from gate.in-addr.de ([212.8.193.158]:13 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S317305AbSIINVn>;
	Mon, 9 Sep 2002 09:21:43 -0400
Date: Mon, 9 Sep 2002 15:27:13 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Oktay Akbal <oktay.akbal@s-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: md multipath with disk missing ?
Message-ID: <20020909132713.GA29@marowsky-bree.de>
References: <Pine.LNX.4.44.0209091504270.12771-100000@omega.s-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0209091504270.12771-100000@omega.s-tec.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-09T15:08:31,
   Oktay Akbal <oktay.akbal@s-tec.de> said:

> Can someone tell me, how md multipathing works, when a drive fails
> completly ?

Well, if the drive (not the path to it) fails _completely_, it won't be
detected by the md autostart (as it can't find the md superblock).

If it fails completely during runtime, all paths but the last one to it will
be disabled, as a drive failure can't be distinguished from a path failure in
the wonderful 2.4 error handling ;-)

But then, all requests send down the last path will fail, because the target
is broken, not the path.

In short, multipathing doesn't help a bit here; how could it?

> Does this only work with raid-autodetection ?
> When no autodetection is done and a drive is missing, would a raidstart
> kill the raid, since the drives are now available with other devices (sda
> instead of former sdb...) ?

I don't understand your question, sorry.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

