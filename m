Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbTLRAE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbTLRAE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:04:56 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:3476 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264875AbTLRAEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:04:54 -0500
Date: Thu, 18 Dec 2003 01:04:52 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc-3.3.2 vs 2.6.0-test11
Message-ID: <20031218000452.GA4289@werewolf.able.es>
References: <20031217113742.GC2074@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031217113742.GC2074@werewolf.able.es> (from jamagallon@able.es on Wed, Dec 17, 2003 at 12:37:42 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.17, J.A. Magallon wrote:
> hi all..
> 
> Are there any known issues wrt gcc-3.3.2 ?
> I built test11 with gcc-3.3.1 and worked fine, the same config built with
> 3.3.2 does not pass init launch:
> 
> INIT version 2.85 booting
> 
> and nothing more....
> 
> I have to check, but I think it also miscompiles 2.4. I rebuilt a kernel on a
> remote box (2.4.23 + assorted patches), that worked fine under 3.3.1, and
> after reboot the box didn't came to life, no ping.
> 

Well, it fails to compile also 2.4. A 2.4 kernel that worked fine hangs when
launching init if built with this gcc. It boots again if is built at -O instead
of -O2.

I think it is a Mandrake specific problem, as changelog reads:

* Tue Dec 16 2003 Gwenole Beauchesne <gbeauchesne@mandrakesoft.com> 3.3.2-2mdk

- Add gcj(1), aka make gc happy
- Add [ep]mmintrin.h for even for SSE/PNI intrinsics
- Move cc1 to gcc-cpp, thusly nuking gcc dep for XFree86
- Remove -funit-at-a-time from -O2 since it is memory hungry

* Mon Dec 15 2003 Gwenole Beauchesne <gbeauchesne@mandrakesoft.com> 3.3.2-1mdk

- 3.3.2 + 3.3-hammer branch (2003/12/08)

I think I don't like that hammer branch...

Thanks.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.0-test11-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
