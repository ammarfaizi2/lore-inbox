Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284336AbRLGTOi>; Fri, 7 Dec 2001 14:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285471AbRLGTO2>; Fri, 7 Dec 2001 14:14:28 -0500
Received: from c842c.nat.may.ka0.zugschlus.de ([212.126.200.66]:63497 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S284336AbRLGTOV>; Fri, 7 Dec 2001 14:14:21 -0500
Date: Fri, 7 Dec 2001 20:14:20 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16, 8139too not loadable as a module - unresolved symbols
Message-ID: <20011207201420.B27154@torres.ka0.zugschlus.de>
In-Reply-To: <20011127150800.A25438@torres.ka0.zugschlus.de> <1006903886.1285.2.camel@marek.almaran.home> <20011128083950.A30510@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011128083950.A30510@torres.ka0.zugschlus.de>; from mh+linux-kernel@zugschlus.de on Wed, Nov 28, 2001 at 08:39:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 08:39:50AM +0100, Marc Haber wrote:
> I am using Debian's kernel-package [1], and did the usual procedure for
> both kernels, that I usually do:
> make-kpkg clean
> make-kpkg --revision=3:today.0 build
> fakeroot debian/rules kernel-image-deb
> 
> This procedure has resulted in a useable kernel .deb package for the
> last 18 months, and has resulted in a useable kernel .deb package for
> 2.4.16 with non-modularized 8139too.

Just for the record, my fault was not having modutils installed when I
built the kernel in a chroot. The kernel-image-deb step threw an
error, so I installed modutils and repeated that step which resulted
in an unuseable kernel.

A more in-depth investigation showed that the missing modutils had an
influence on the kernel build process that did not make it fail.
Repeating the whole process starting with the first step with modutils
installed resulted in a kernel with useable 8139too driver.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
