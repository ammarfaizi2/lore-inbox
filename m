Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSBIMnc>; Sat, 9 Feb 2002 07:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288925AbSBIMnW>; Sat, 9 Feb 2002 07:43:22 -0500
Received: from fungus.teststation.com ([212.32.186.211]:55058 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S288923AbSBIMnQ>; Sat, 9 Feb 2002 07:43:16 -0500
Date: Sat, 9 Feb 2002 13:43:07 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.18pre6+ll: autofs+smbfs: processes in D state
In-Reply-To: <200202091219.g19CJEt23147@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0202091322520.5384-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Denis Vlasenko wrote:

> Note that NT box was rebooted, not shut down. I brought it back on and even 
> restarted download of unlucky mp3 (via NT downloader). Since NT box was 
> available on the network I thought smbfs will reestablish SMB connection, as 
> NFS do in similar scenario (server reboot).

It does, but that reconnect is limited by the same server lock as the
others. Also, SMB has state so you do loose certain things on a server
reboot (eg open files).

> Hmmm, maybe... I tried to kill -KILL automounter, forgot to do that to 
> smbmount.

That does not help. Killing smbmount does not affect smbfs until the
connection is lost, and it doesn't improve anything. Just a normal umount.

/Urban

