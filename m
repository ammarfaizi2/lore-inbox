Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSHOWSQ>; Thu, 15 Aug 2002 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSHOWSQ>; Thu, 15 Aug 2002 18:18:16 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:23248 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S316070AbSHOWSP>; Thu, 15 Aug 2002 18:18:15 -0400
Date: Thu, 15 Aug 2002 12:13:34 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Scorpion <scorpionlab@ieg.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flush issues in boot phase
Message-ID: <20020815121334.A1940@linux-m68k.org>
References: <200208131425.19328.scorpionlab@ieg.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208131425.19328.scorpionlab@ieg.com.br>; from scorpionlab@ieg.com.br on Tue, Aug 13, 2002 at 02:25:19PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 02:25:19PM -0300, Scorpion wrote:
> 
> Hi fellows,
> I'm still trying to boot my dual AMD 1800XP machines (not MP).
> I got one more step disabling MP 1.4 support on BIOS setup, but now
> (using 2.4.19 kernel) I have a more general question.
> The boot phase stop exactly with the message:
> 
> Partition check:
> hda:
> 
> Should I consider that the kernel stop exactly in this point 

it stops exactly between this printk and the next (unreached) one.

See fs/partitions, probably read_dev_sector hangs so put printk's
around that.

Richard
