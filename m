Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTA1MN0>; Tue, 28 Jan 2003 07:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbTA1MN0>; Tue, 28 Jan 2003 07:13:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22400
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265230AbTA1MMv>; Tue, 28 Jan 2003 07:12:51 -0500
Subject: Re: PID of multi-threaded core's file name is wrong in 2.5.59
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030125.135611.74744521.maeda@jp.fujitsu.com>
References: <20030125.135611.74744521.maeda@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 12:21:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-25 at 04:56, MAEDA Naoaki wrote:
> Hi,
> 
> I found sometimes pid of muitl-threaded core's file name shows
> wrong number in 2.5.59 with NPTL-0.17. Problem is, pid of core file
> name comes from currnet->pid, but I think it should be current->tgid.

The value needs to be unique so that you can dump multiple threads
at the same time and not have one overwrite another. You might want
to add the tgid as another format type to the core name formatting so
users can select the behaviour you desire however ?

