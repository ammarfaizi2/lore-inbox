Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267401AbSLLBvm>; Wed, 11 Dec 2002 20:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267402AbSLLBvm>; Wed, 11 Dec 2002 20:51:42 -0500
Received: from xf86.isc.org ([204.152.184.37]:43533 "EHLO public.xfree86.org")
	by vger.kernel.org with ESMTP id <S267401AbSLLBvl>;
	Wed, 11 Dec 2002 20:51:41 -0500
Date: Wed, 11 Dec 2002 20:58:54 -0500
From: David Dawes <dawes@XFree86.Org>
To: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org,
       davej@suse.de, faith@redhat.com, dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: 2.4.20 AGP for I845 wrong ?
Message-ID: <20021211205854.A7654@xfree86.org>
References: <fa.jjk71mv.1kja10g@ifi.uio.no> <3DF72A91.5080804@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DF72A91.5080804@epfl.ch>; from Nicolas.Aspert@epfl.ch on Wed, Dec 11, 2002 at 01:07:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 01:07:45PM +0100, Nicolas ASPERT wrote:
>Margit Schubert-While wrote:
>>  From drivers/char/agp/agpgart_be.c
>> 4554,4559
>>     { PCI_DEVICE_ID_INTEL_845_G_0,
>>                  PCI_VENDOR_ID_INTEL,
>>                  INTEL_I845_G,
>>                  "Intel",
>>                  "i845G",
>>                  intel_830mp_setup },
>> 
>> Surely this is wrong or ?
>> Should be "intel_845_setup", I think.
>> 
>
>IIRC, the 845G is a "new" version of the 830MP chipset (it had been
>added by Abraham vd Merwe & Graeme Fisher some months ago), but acts
>basically just as the 830MP. Therefore the entry is correct.... Or maybe
>if it gets confusing adding a comment would not hurt...

No, I think it should be intel_845_setup too, since the 845G docs on
Intel's public web site show that the behaviour is like the 845 when
the on-board graphics isn't enabled.  I made that change in my
locally maintained version of the agpgart driver a little while ago,
but haven't had the opportunity to test it with an external AGP card
in an 845G box yet.

David
-- 
David Dawes
Release Engineer/Architect                      The XFree86 Project
www.XFree86.org/~dawes
