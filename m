Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbUK3KF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUK3KF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 05:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbUK3KF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 05:05:29 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46749 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261874AbUK3KFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 05:05:12 -0500
Subject: Re: [lkdump-develop] Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Itsuro Oda <oda@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <20041130083116.3D92.ODA@valinux.co.jp>
References: <20041130083116.3D92.ODA@valinux.co.jp>
Content-Type: text/plain
Organization: 
Message-Id: <1101810405.14413.329.camel@wks126533wss.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Nov 2004 15:56:45 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-11-30 at 06:01, Itsuro Oda wrote:
> Hi,
> 
> I am a developer of an yet another crash dump (mkdump). 
> I'd like to know conditions which cause taking dump fail.
> It is helpful to share those informations for dump developers.
> 
> I have three major concerns about taking dump.
> * interrupt disable
>   taking dump should be run under interrput disable.
>   diskdump is aware of that. How about kexec based dump ?
> * avoid deadlock
>   taking dump should not get any locks to avoid deadlock. (?)
>   I think there are many posibility of deadlock in the kexec
>   based dump (from crash occur to initiate the new kernel).
>   (mkdump does not meet neither yet. :-p)

Now kexec based dump is in -mm tree. Could you please have a look at the
code and point out if any problems you see.

> * be sure to get the other CPUs' register value
>   How are the other CPUs' regsiter value get and how are the 
>   other CPUs stoped ?

Kexec based dump does capture the other CPU's register values.

> (of course the goal of mkdump is to solve these points 
>  although not implemented yet :-)
> 
> Any other points to be consider ?
> Comments and suggestions are welcome.
> 
> Thank you.

Thanks
Vivek


