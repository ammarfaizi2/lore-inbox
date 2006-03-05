Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWCESMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWCESMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWCESMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:12:30 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:60195 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750797AbWCESMa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:12:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nj22UVmW+gxu+E1JnXrqNUuDixNEygzbTgMcJRHJjoAU+esMbv9QnaAcUSPfXTRlayjnJ/wyqwZec5LYx9wHjrjq2xHubscrMAQq/LEHkkN/ss1N6okh6aqQEMrnfpN4nwqrVbHPlaiP8+YgcJSE/NmHKRTOLFRH5HHTlGPEVfA=
Message-ID: <7d40d7190603051012p16ed826cx@mail.gmail.com>
Date: Sun, 5 Mar 2006 19:12:29 +0100
From: "Aritz Bastida" <aritzbastida@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: MMAP: How a driver can get called on mprotect()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, i have a driver which lets a region of its memory to be mmaped.
The memory can be read and written to from user processes, but sometimes
i just want to let read it, not write it.

I can do that playing with VM_READ and VM_WRITE in the driver's mmap() function,
and refuse to mmap if the user process tries to mmap for writing.

The problem is that, those flags can be changed from userspace with
mprotect() and my mapping count (vma's open and close functions) got
corrupted. Is there any way to get called when the process issues
mprotect(). Should I turn off VM_MAYWRITE and that kind of flags?

I hope my question is clear
Thank you
