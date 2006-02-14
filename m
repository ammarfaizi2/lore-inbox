Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWBNG5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWBNG5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBNG5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:57:08 -0500
Received: from harddata.com ([216.123.194.198]:5819 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id S1030367AbWBNG5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:57:06 -0500
Date: Mon, 13 Feb 2006 23:55:50 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, davem@davemloft.net,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.de,
       James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060214065550.GA27216@mail.harddata.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com> <20060213001240.05e57d42.akpm@osdl.org> <1139821068.2997.22.camel@laptopd505.fenrus.org> <20060214030821.GA23031@mail.harddata.com> <1139887857.11659.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139887857.11659.28.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:30:56PM -0500, Lee Revell wrote:
> On Mon, 2006-02-13 at 20:08 -0700, Michal Jaegermann wrote:
> > On Mon, Feb 13, 2006 at 09:57:48AM +0100, Arjan van de Ven wrote:
> > > 
> > > 2.6.15 went into distros as well, such as Fedora Core 4 ;)
> > 
> > And promptly broke laptop suspension.  See, for example:
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180998
> 
> It broke suspension on YOUR laptop - the bug report does not give a make
> and model.

Yes, indeed.  It is Acer Travelmate 230 and it is using
'acpi_sleep=s3_bios'.  The bug report noted though that the
following showed up:

Yenta O2: res at 0x94/0xD4: 00/ca
Yenta O2: enabling read prefetch/write burst
    ACPI-0265: *** Error: No installed handler for fixed event [00000002]

which was not something which I have seen before and indeed on
another laptop with the same kernel is absent.  But it was also not
there on 230 with earlier kernels.

BTW - this another laptop mentioned above, which happens to be Acer
Travelmate 740, is doing suspend/resume with 2.6.15 kernel, and no
'acpi_sleep=s3_bios' is needed,  but shortly after such cycle both
an external mouse and a touchpad go crazy and a mouse pointer
refuses to move in X from the left screen edge.  Not very useful and
so far I did not found a way to reset rodents.  No problems of that
sort before I will try to suspend.  Always something "interesting".
It is actually possible that in this case this is a problem with
"ATI Radeon Mobility M6" video driver which gets upset by suspend
(or some other pieces driving display) but I do not really know.

   Michal
