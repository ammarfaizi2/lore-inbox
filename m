Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285036AbRLQHnF>; Mon, 17 Dec 2001 02:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285041AbRLQHmz>; Mon, 17 Dec 2001 02:42:55 -0500
Received: from [195.66.192.167] ([195.66.192.167]:40709 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S285036AbRLQHmr>; Mon, 17 Dec 2001 02:42:47 -0500
Content-Type: text/plain;
  charset="PT 154"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [PATCH] kill(-1,sig)
Date: Mon, 17 Dec 2001 09:41:33 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112170701.fBH71uW04275@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200112170701.fBH71uW04275@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Message-Id: <01121709413305.01828@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2001 05:01, Richard Gooch wrote:
>   Hi, all. To followup on the change in 2.5.1 which sends a signal to
> the signalling process when send_pid==-1, I have a definate case where
> the new behaviour is highly undesirable, and I would say broken.
>
> shutdown(8) from util-linux (*not* the version that comes with the
> bloated monstrosity known as SysVInit) uses the sequence:

Hi Richard, I'm using your new init and happy with it (thanks!).
I am very willing to discuss other side of a coin (i.e. shutdown sequence),
let's do it off the list.

> 	kill (-1, SIGTERM);
> 	sleep (2);
> 	kill (-1, SIGKILL);
>
> to ensure that all processes not stuck in 'D' state are killed.
>
> With the new behaviour, shutdown(8) ends up killing itself. This is no
> good, because the shutdown process doesn't complete (i.e. unmounting
> of filesystems, calling sync(2) and good stuff like that).

I don't use your shutdown, I found it possible to spawn a shell script
in a new process group and use killall5 to term/kill everything except this 
process group. It works. (But yesterday I saw fsck again... something did not
get umounted?) I can mail my scripts to you for a little discussion. Mail me.
--
vda
