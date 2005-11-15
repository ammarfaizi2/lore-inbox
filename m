Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVKOTU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVKOTU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVKOTU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:20:59 -0500
Received: from amdext4.amd.com ([163.181.251.6]:30885 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S965010AbVKOTU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:20:58 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Date: Tue, 15 Nov 2005 14:21:07 -0500
User-Agent: KMail/1.8
cc: linux-kernel@vger.kernel.org, "Hubertus Franke" <frankeh@watson.ibm.com>,
       "Dave Hansen" <haveblue@us.ibm.com>
References: <20051114212341.724084000@sergelap>
In-Reply-To: <20051114212341.724084000@sergelap>
MIME-Version: 1.0
Message-ID: <200511151321.08860.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 15 Nov 2005 19:20:47.0708 (UTC)
 FILETIME=[AEC3D9C0:01C5EA19]
X-WSS-ID: 6F64EA851M4569500-01-01
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 November 2005 15:23, Serge E. Hallyn wrote:
> --
>
> I'm part of a project implementing checkpoint/restart processes.
> After a process or group of processes is checkpointed, killed, and
> restarted, the changing of pids could confuse them.  There are many
> other such issues, but we wanted to start with pids.
>

I've read through the rest of this thread, but it seems to me that the real 
problems are in the basic assumptions you are making that are driving the 
rest of this effort and perhaps we should be examining those assumptions 
instead of your patch.   

For example, from what I've read (particularly Hubertus's post that the pid 
could be in a register), I'm inferring that what you want to do is to be able 
to checkpoint/restart an arbitrary process at an arbitrary time and without 
any special support for checkpoint/restart in that process.   

Also (c. f. Dave Hansen's post on the number of Xen virtual machines 
required),  you appear to think that the number of processes on the system 
for which checkpoint/restart should be enabled is large (more or less the 
same as the number of processes on the system).

Am I reading this correctly?

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

