Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbTJIKd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTJIKd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:33:59 -0400
Received: from vwisb7.vkw.tu-dresden.de ([141.30.51.183]:51369 "EHLO
	vwisb7.vkw.tu-dresden.de") by vger.kernel.org with ESMTP
	id S261535AbTJIKd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:33:56 -0400
Date: Thu, 9 Oct 2003 12:33:55 +0200
From: Torsten Werner <email@twerner42.de>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS speed problem when appending data to existing files
Message-ID: <20031009103355.GA23290@vwisb7.vkw.tu-dresden.de>
Mail-Followup-To: Torsten Werner <email@twerner42.de>,
	linux-kernel@vger.kernel.org
References: <200310090008.14366.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310090008.14366.bernd-schubert@web.de>
X-Operating-System: Linux 2.4.21 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bernd,

On 2003-10-09, Bernd Schubert wrote:
> 2.4.22 has a client-side nfs-bug causing this. I'm not sure if this is
> already fixed in 2.4.23-pre6, so I suggest you downgrade to 2.4.21.

Thanks, that does avoid the error messages in the kernel log but it does
not solve the problem. You can download a strace log from
http://twerner.debian.net/strace.out.bz2 . You will see a programm that
repeatedly opens a file in append mode, writes some data and closes the
file. Sometimes the close need overs half a second which is far to much.
(Please just 'grep close strace.out' to see it clearly.)

It did work with some older kernel that I have already deinstalled. :-(

Regards,
Torsten

-- 
Torsten Werner                         Dresden University of Technology
email@twerner42.de                   +49 351 46336711 / +49 162 3123004
http://www.twerner42.de/                      telefax: +49 351 46336809

