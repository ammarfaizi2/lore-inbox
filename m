Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030692AbWFOPce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030692AbWFOPce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030693AbWFOPce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:32:34 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:40164 "EHLO mail43.e.nsc.no")
	by vger.kernel.org with ESMTP id S1030692AbWFOPce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:32:34 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: SATA Conflict with PATA DMA
References: <87odz2kc0k.fsf@esben-stien.name> <4441224C.5010905@garzik.org>
	<87fyk4mb2x.fsf@esben-stien.name> <87bqusmat7.fsf@esben-stien.name>
From: Esben Stien <b0ef@esben-stien.name>
Date: Thu, 15 Jun 2006 19:29:02 +0200
In-Reply-To: <87bqusmat7.fsf@esben-stien.name> (Esben Stien's message of
 "Sun, 23 Apr 2006 20:00:36 +0200")
Message-ID: <878xny8h0h.fsf@esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Stien <b0ef@esben-stien.name> writes:

> It seems it will be fixed in 2.6.17

I ran 2.6.17-rc6-rt3 with combined_mode=libata and this worked to make
the hd work at full speed, but something weird is happening:

It lists both hd's as the same device: 

#df -h
/dev/sda1             276G  276G  727M 100% /
/dev/sda1              73G  1,1G   72G   2% /mnt/fs1

#ls /
bck-sys-20051017  boot  etc-2006-02-16  lib    nfs   root   src  tmp   var
bin               dev   etc-2006-02-17  media  opt   sbin   srv  udev
blfs              etc   home            mnt    proc  share  sys  usr

#ls /mnt/fs1
b0ef  bacula

This must clearly be a bug.

-- 
Esben Stien is b0ef@e     s      a             
         http://www. s     t    n m
          irc://irc.  b  -  i  .   e/%23contact
           sip:b0ef@   e     e 
           jid:b0ef@    n     n
