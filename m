Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278113AbRJWRaN>; Tue, 23 Oct 2001 13:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278112AbRJWRaD>; Tue, 23 Oct 2001 13:30:03 -0400
Received: from mail.cps.matrix.com.br ([200.196.9.5]:22280 "EHLO
	smtp.cps.matrix.com.br") by vger.kernel.org with ESMTP
	id <S278107AbRJWR3w>; Tue, 23 Oct 2001 13:29:52 -0400
Date: Tue, 23 Oct 2001 15:30:15 -0200
To: linux-kernel@vger.kernel.org
Subject: Re: SiS630S FrameBuffer & LCD
Message-ID: <20011023153015.F4709@khazad-dum>
In-Reply-To: <5.1.0.14.0.20011023161901.00a65870@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.0.20011023161901.00a65870@mail.amc.localnet>; from sgy@amc.com.au on Tue, Oct 23, 2001 at 04:54:59PM +1000
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@debian.org (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Stuart Young wrote:
> Like my previous SiS post, I'm once again using the Clevo lp200t (SiS630S 
> chipset), and trying to enable the SiS FrameBuffer device. Once again, this 
> happens on 2.4.9, 2.4.10, and 2.4.12.

Well, that piece of ***** chipset will ONLY work if you talk to it through
the VESA BIOS in a laptop I have here.  This is fine for XFree86 (we used
the VESA driver), but I don't know if this would work for the kernel VESA
framebuffer driver.

The SiS drivers will basicaly screw your hardware up. You *must* talk to it
through the BIOS, or it will not manage to get the video/LCD timings right or
even hung the PCI bus. Smells like the chipset needs extra data that the
current drivers do not know how to set.

> In either case, the machine continues to run happily, and I can either ssh 

Lucky you. Our laptop got a PCI buffer hung out of the deal.

> It seems plausible that the documentation that SiS has provided is now 
> out--of-date, and/or the drivers are assuming the wrong things in cases of 
> the unknown. The problem is easily reproducible, and the SiS630S chipset 
> (which seems to be the one affected, but may not necessarily be the only 
> one) is becoming more widespread in laptop/all-in-one PC's.

Indeed. We need fully updated docs from SiS on how to deal with their newest
"contribution" to the onboard-video family.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
