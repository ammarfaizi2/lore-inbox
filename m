Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUIAPXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUIAPXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUIAPXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:23:32 -0400
Received: from smtp08.auna.com ([62.81.186.18]:6345 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S266867AbUIAPX2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:23:28 -0400
Date: Wed, 01 Sep 2004 15:23:27 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: microcode_ctl vs udev
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1093906213l.24821l.1l@werewolf.able.es>
	<1093950085.32684.3.camel@localhost.localdomain>
X-Mailer: Balsa 2.2.4
Message-Id: <1094052207l.8632l.0l@werewolf.able.es>
X-Balsa-Fcc: file:///home/magallon/mail/sentbox
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.08.31, Alan Cox wrote:
> On Llu, 2004-08-30 at 23:50, J.A. Magallon wrote:
> > It looks like udev creates /dev/microcode, but microcode_ctl looks for
> > /dev/cpu/microcode.
> > 
> > Which is the right location ?
> 
> /dev/cpu/microcode according to the LANANA registration table
> 


I solved this with a rule in rules.d:

KERNEL="microcode",     NAME="cpu/microcode" 

But where is the default ? Kernel or userspace ? And why is it not created
in the right place ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Beta 1) for i586
Linux 2.6.8.1-mm2 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #3






