Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287632AbSA3Asn>; Tue, 29 Jan 2002 19:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSA3Ase>; Tue, 29 Jan 2002 19:48:34 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:14087 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S287552AbSA3AsQ>; Tue, 29 Jan 2002 19:48:16 -0500
Date: Wed, 30 Jan 2002 08:44:04 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, <jdthood@mail.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <sfr@canb.auug.org.au>,
        <skraw@ithnet.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <104D80077517@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0201300841160.3719-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/30/2002
 08:48:12 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/30/2002
 08:48:14 AM,
	Serialize complete at 01/30/2002 08:48:14 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Petr Vandrovec wrote:
> I've got an idea - if you were saying that ping host->guest is fine,
> but other way around it does not work. Can you apply
> ftp://platan.vc.cvut.cz/pub/vmware/vmware-ws-1455-update5.tar.gz
> to your VMware 3.x? Stock vmware-3.x modules use netif_rx() instead
> of netif_rx_ni(), and so network bottom half was not run under some
> conditions.

Applied patch. Still same problem.

On host
	modprobe apm idle_threshold=100, guest ping lo, no problem
	modprobe apm idle_threshold=99,  guest ping lo, slow

Jeff.

