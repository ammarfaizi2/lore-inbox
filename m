Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265922AbUF2TID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUF2TID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUF2TID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:08:03 -0400
Received: from fmx4.freemail.hu ([195.228.242.224]:25367 "HELO
	fmx4.freemail.hu") by vger.kernel.org with SMTP id S265922AbUF2THz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:07:55 -0400
Date: Tue, 29 Jun 2004 21:07:42 +0200 (CEST)
From: Debi Janos <debi.janos@freemail.hu>
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040629115033.46383033.davem@redhat.com>
Message-ID: <freemail.20040529210742.77560@fm2.freemail.hu>
X-Originating-IP: [81.182.194.181]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> írta:

> On Tue, 29 Jun 2004 11:22:56 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > To turn of receive buffer auto-tuning:
> > 	sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
> > 	sysctl -w net.ipv4.tcp_default_win_scale=0
> 
> It may be just the window scaling that's causing the grief
> so people can try just setting tcp_default_win_scale to zero
> and leaving tcp_moderate_rcvbuf enabled.
> 
> That would be an important data-point.

Yes. 

sysctl -w net.ipv4.tcp_default_win_scale=0

is enough. 

(1.2GHz 55C) root@alderaan:/home/trey $ sysctl
net.ipv4.tcp_moderate_rcvbuf
net.ipv4.tcp_moderate_rcvbuf = 1
(1.2GHz 55C) root@alderaan:/home/trey $ sysctl
net.ipv4.tcp_default_win_scale
net.ipv4.tcp_default_win_scale = 0
(1.2GHz 54C) root@alderaan:/home/trey $

With this setting i have not problem, working everything is
fine.

