Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbUELMeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbUELMeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUELMeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:34:06 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:18941 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S265008AbUELMeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:34:02 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Slawomir Orlowski" <orlowscy@hotpop.com>
Subject: Re: problem with kernel 2.4.26 installation
Date: Wed, 12 May 2004 14:34:43 +0200
User-Agent: KMail/1.6.2
References: <1ec701c4379c$075d5700$4900a8c0@cympak.com>
In-Reply-To: <1ec701c4379c$075d5700$4900a8c0@cympak.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200405121434.43355.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 May 2004 23:07, you wrote:
> Hello there,
>
> I have got Dell server PowerEdge 2500 with dell installed RH 7.2 and
> 2.4.7-10 kernel (rpm installation).
> I wanted to upgrade it to 2.4.26 from source.
>
> So I have done like always:
> make mrproper,
> copied .config from 2.4.7 (did make menuconfig)
> make dep, clean, bzImage, modules, modules_install, install
>
> and I got:
> "
> bsetup.s: Assembler messages:
> bsetup.s:2503: Warning: indirect lcall without `*'
> Root device is (8, 8)
> Boot sector 512 bytes.
> Setup is 4768 bytes.
> System is 835 kB
> + '[' -x /root/bin/installkernel ']'
> + '[' -x /sbin/installkernel ']'
> + exec /sbin/installkernel 2.4.26 bzImage
> /usr/src/linux-2.4.26/System.map ''
> /etc/lilo.conf: No such file or directory
> make[1]: *** [install] Error 1
> make: *** [install] Error 2

As far as I can tell this problem is related to your "/sbin/installkernel" 
script... it finds LILO and so calls it, but the lilo configuration file 
doesn't exist ;-)!

I think that "/sbin/installkernel" is doing the right thing (from its point 
of view)...

Shortly: REMOVE LILO, if you don't use it why is it installed?

Another thing you can do is to change "/sbin/installkernel" to never call 
LILO.


Bye

-- 
	Paolo Ornati
	Linux v2.6.6
