Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUC1SZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUC1SZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:25:32 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:36736
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S262335AbUC1SZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:25:24 -0500
Date: Sun, 28 Mar 2004 10:25:22 -0800
From: Phil Oester <kernel@linuxace.com>
To: Hasso Tepper <hasso@estpak.ee>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dlstevens@ibm.com,
       linux-net@vger.kernel.org
Subject: Re: Kernel panic in 2.4.25
Message-ID: <20040328182522.GA22382@linuxace.com>
References: <200403260035.09821.hasso@estpak.ee> <20040328163210.GA21803@linuxace.com> <20040328164936.GA21839@linuxace.com> <200403282033.16204.hasso@estpak.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403282033.16204.hasso@estpak.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have CONFIG_IP_MULTICAST enabled in your .config?  I don't, and
a couple of the changes in this changeset depend upon it.

I also run ospfd, so maybe you've hit upon something here...cc'ing 
linux-net for comment

Phil

p.s. here's a bookmarkable link to that changeset:

http://linux.bkbits.net:8080/linux-2.4/cset@401ee07fZyaInErbsMYxlCIQSlevFQ?nav=index.html|ChangeSet@-9M

On Sun, Mar 28, 2004 at 08:33:16PM +0300, Hasso Tepper wrote:
> Now when linux.bkbits.net is working again, I walked through patches 
> between 2.4.25-pre8 and 2.4.25-rc1 and reverted this patch -
> http://linux.bkbits.net:8080/linux-2.4/cset%
> 401.1290.17.1?nav=index.html|ChangeSet@-9M
> 
> This solved problem for me, seems (tested only with 2.4.25-rc1 for 
> now). I had feeling that it's related to multicast from the beginning 
> because I couldn't reproduce panic when I hadn't ospfd daemon running 
> (ospf uses multicast).
