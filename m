Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285216AbRL2SgJ>; Sat, 29 Dec 2001 13:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285213AbRL2Sf7>; Sat, 29 Dec 2001 13:35:59 -0500
Received: from khazad-dum.debian.net ([200.196.10.6]:16512 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S285203AbRL2Sfv>; Sat, 29 Dec 2001 13:35:51 -0500
Date: Sat, 29 Dec 2001 16:35:45 -0200
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon instabilities and VIA. "PCI latency" patch for Linux (for KT266A chipset only)
Message-ID: <20011229163545.A2197@khazad-dum>
In-Reply-To: <200112291436.GAA20655@quantum.cicese.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: =?iso-8859-1?Q?=3C200112291436=2EGAA20655=40quantum=2Ecicese=2Emx=3E=3B_?=
 =?iso-8859-1?Q?from_mirsev=40cicese=2Emx_on_S=E1b=2C_Dez_29=2C_2001_at_0?=
 =?iso-8859-1?Q?6:36:19_-0800?=
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@rcm.org.br (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Serguei Miridonov wrote:
> program from H.Oda! (http://www.h-oda.com/). Finally I wrote a very
> dirty hack which fixes some issues in Linux too. Now I can playback
> video using both DXR3 and DC10plus card but in some conditions the
> system still freezes. It happens when video is played back by DC10plus
> in xawtv window. This makes me to think that problem is caused by
> multiple PCI bus master transfers.

Hmm... this is bad. Just to make it clear, the lockup was there before your
module, right?

BTW, disabling PCI Master Read Caching in BIOS appears to have decreased
memory performance on my machine by a very small ammount (Asus A7V, KT133
chipset, also affected by the low-performance PCI bug/misdesign in VIA
chipsets).  Since your patch also does that, you may want to verify if that
also happens in your machine and document it.

One can use setpci(1) to fix the device latency to a high value in the buses
that have IDE controllers, btw. This, along with options in the system BIOS
may allow one to test much of the suggested patches in a non-KT266A VIA
chipset.

> The distribution also includes KT266A registers descriptions from H.Oda!
> and configuration dumps. These files are _not_ covered by GNU License.

Could you please send me the KT133 description files, if you have them?  I
might merge in a change to your patch that deals with KT133 (and KT133A if
you include that info as well). I can only test KT133.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
