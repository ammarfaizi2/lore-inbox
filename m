Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUIAI20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUIAI20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUIAI20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:28:26 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:19503 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263795AbUIAI2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:28:15 -0400
Message-ID: <2dc3ece804090101283ea96cc6@mail.gmail.com>
Date: Wed, 1 Sep 2004 10:28:15 +0200
From: Peder Stray <peder.stray@gmail.com>
Reply-To: Peder Stray <peder.stray@gmail.com>
To: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: problem with ACPI and suspend
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03B0DA18@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <B44D37711ED29844BEA67908EAF36F03B0DA18@pdsmsx401.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 15:35:11 +0800, Li, Shaohua <shaohua.li@intel.com> wrote:
> Did you load ACPI button driver?

The botton module is loaded at all times yes. Otherwis i guess it
wouldn't have worked at all. When i close the lid the first time, my
laptop suspends as it should, the second time it also suspends ass it
should, but when it wakes up from this suspend it gets the message i
orignially stated and no more messages are passed so the
resume-scripts won't get called ever again until i reboot, and thus it
won't suspend by closing the lid either.

list of modules loaded:

Module                  Size  Used by
parport_pc             21249  1 
lp                      9133  0 
parport                35977  2 parport_pc,lp
autofs4                20677  0 
ds                     12869  4 
yenta_socket           15937  1 
pcmcia_core            51336  2 ds,yenta_socket
sunrpc                141861  1 
xircom_cb              10177  0 
microcode               5601  0 
md5                     3905  1 
ipv6                  217349  10 
vfat                   12481  1 
fat                    39393  1 vfat
uhci_hcd               28505  0 
button                  4825  0 
battery                 7117  0 
asus_acpi               9177  0 
ac                      3533  0 
ext3                   96937  4 
jbd                    66521  1 ext3
dm_mod                 47317  5 


> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> >owner@vger.kernel.org] On Behalf Of Peder Stray
> >Sent: Wednesday, September 01, 2004 3:00 AM
> >To: linux-kernel@vger.kernel.org
> >Subject: problem with ACPI and suspend
> >
> >ACPI works quite ok on my laptop, currently running 2.6.8, but when i
> >resume from suspend the second time after a boot i get the following
> >message:
> >
> >    ACPI-0286: *** Error: No installed handler for fixed event
> [00000002]
> >
> >and the acpi subsystems seem to stop sending events, as no scripts
> >gets called after this. Anyone had similar problems? I really would
> >like to have working suspend/resume more than once after each reboot
> >;)
> >
> >--
> >  Peder Stray
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
  Peder Stray
