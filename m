Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273705AbRIQViy>; Mon, 17 Sep 2001 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273704AbRIQVis>; Mon, 17 Sep 2001 17:38:48 -0400
Received: from codepoet.org ([166.70.14.212]:63339 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S273703AbRIQViN>;
	Mon, 17 Sep 2001 17:38:13 -0400
Date: Mon, 17 Sep 2001 15:38:39 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010917153839.A26787@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010917151957.A26615@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010917151957.A26615@codepoet.org>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.8-ac10-rmk1-rmk2, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 17, 2001 at 03:19:57PM -0600, Erik Andersen wrote:
> $ cat /proc/partitions
> major minor  #blocks  name
> 
>    8     0     620704 sda
>    8    16     620704 sdb
>    8     0     620704 sda
>    8    16     620704 sdb
>    8     0     620704 sda
>    8    16     620704 sdb
>    8     0     620704 sda
>    8    16     620704 sdb
>    8     0     620704 sda
>    8    16     620704 sdb
>    8     0     620704 sda
>    8    16     620704 sdb
>    8     0     620704 sda
>    8    16     620704 sdb
>    <continues forever>
> 

Reverting drivers/scsi/sd.c to stock 2.4.9 fixes it, BTW,

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
