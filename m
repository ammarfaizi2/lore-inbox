Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281404AbRKPN0F>; Fri, 16 Nov 2001 08:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKPNZz>; Fri, 16 Nov 2001 08:25:55 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:28819 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S281393AbRKPNZn>; Fri, 16 Nov 2001 08:25:43 -0500
From: Christoph Rohland <cr@sap.com>
To: Cristiano Paris <c.paris@libero.it>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ramfs and inode
In-Reply-To: <Pine.LNX.4.33.0111151746490.405-100000@lisa.rhpk.springfield.inwind.it>
Organisation: SAP LinuxLab
Date: 16 Nov 2001 14:25:29 +0100
In-Reply-To: <Pine.LNX.4.33.0111151746490.405-100000@lisa.rhpk.springfield.inwind.it>
Message-ID: <m3adxmlueu.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristiano,

On Thu, 15 Nov 2001, Cristiano Paris wrote:
> I need an explanation, if possible.
> 
> I'm pretty sure that a VFS' inode which refers to a ramfs' file is
> never released (i.e. deleted) until that is unlinked. Anyway, I
> cannot find a formal verification of this assertion.

Yes, that's the way it is designed. The struct inode _is_ the ramfs
inode. If you delete the inode, the content is gone...

Greetings
		Christoph


