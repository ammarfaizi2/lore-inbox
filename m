Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262292AbSJISZk>; Wed, 9 Oct 2002 14:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262293AbSJISZk>; Wed, 9 Oct 2002 14:25:40 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:50427 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262292AbSJISZf>; Wed, 9 Oct 2002 14:25:35 -0400
Date: Wed, 9 Oct 2002 11:22:54 -0700
From: Chris Wright <chris@wirex.com>
To: Tony Glader <Tony.Glader@blueberrysolutions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: capable()-function
Message-ID: <20021009112254.A25393@figure1.int.wirex.com>
Mail-Followup-To: Tony Glader <Tony.Glader@blueberrysolutions.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210091046230.30467-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210091046230.30467-100000@blueberrysolutions.com>; from Tony.Glader@blueberrysolutions.com on Wed, Oct 09, 2002 at 10:51:50AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Glader (Tony.Glader@blueberrysolutions.com) wrote:
> Hi!
> 
> I was investigating problems with PCMCIA and found that
> capable(CAP_SYS_ADMIN) returns always false in my case. If I'm calling
> capable(CAP_SYS_ADMIN) as root - shouldn't it return true? What could
> cause this? I'm using RH 8.0 and src-rpm of 2.4.18-14 kernel.

Well, it will return true if you _have_ CAP_SYS_ADMIN capability.
Typically root has all effective capabilities (except CAP_SETPCAP).
You can check your effective capabilities in /proc/[pid]/status.
I doubt your system can't get a process with CAP_SYS_ADMIN, you'd have
trouble mounting filesystems, etc... 

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
