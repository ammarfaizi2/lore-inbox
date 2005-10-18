Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVJROyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJROyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJROyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:54:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35543 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750767AbVJROyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:54:22 -0400
Message-ID: <43550C9A.9070306@de.ibm.com>
Date: Tue, 18 Oct 2005 16:54:18 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: OBATA Noboru <noboru.obata.ar@hitachi.com>, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
References: <20050921.205550.927509530.hyoshiok@miraclelinux.com>	<20051006.211718.74749573.noboru.obata.ar@hitachi.com> <20051010174931.223310de.akpm@osdl.org>
In-Reply-To: <20051010174931.223310de.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I was rather expecting that the various groups which are interested in
> crash dumping would converge around kdump once it was merged.  But it seems
> that this is not the case and that work continues on other strategies.
> 
> Is that a correct impression?  If so, what shortcoming(s) in kdump are
> causing people to be reluctant to use it?
On 390, we have standalone dump. That is a tool you can install on a disk
with zipl (like lilo) and that you boot when your server has crashed.
Newer machines also have a hardware feature built-in that does this from the
service element (that is a laptop computer mounted to the big box).
When running on z/VM, there is a command you can enter on z/VM's console
which causes z/VM to create a dump of Linux' memory.
Different from kdump we can even take a dump if our system is so badly
corrupted that you don't even get a panic message. As far as I know, kdump
would require to reserve memory for the extra kernel prior to crash, which
is not the case with our soloutions.
-- 

Carsten Otte
IBM Linux technology center
ARCH=s390
