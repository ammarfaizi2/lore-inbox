Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290806AbSARU3H>; Fri, 18 Jan 2002 15:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290805AbSARU25>; Fri, 18 Jan 2002 15:28:57 -0500
Received: from ns.suse.de ([213.95.15.193]:56068 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290804AbSARU2v>;
	Fri, 18 Jan 2002 15:28:51 -0500
Date: Fri, 18 Jan 2002 21:28:43 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Didier Moens <moensd@xs4all.be>, linux-kernel@vger.kernel.org,
        Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Subject: Re: OOPS in APM 2.4.18-pre4 with i830MP agpgart
Message-ID: <20020118212843.A6416@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Didier Moens <moensd@xs4all.be>,
	linux-kernel@vger.kernel.org, Nicolas Aspert <Nicolas.Aspert@epfl.ch>
In-Reply-To: <3C487E68.1000404@xs4all.be> <E16RfZf-0007nk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16RfZf-0007nk-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 18, 2002 at 08:25:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 08:25:19PM +0000, Alan Cox wrote:
 > > Unfortunately, loading agpgart yields an oops when APM ("apm -s") is 
 > > invoked, both in terminal and in X. APM functions perfectly when agpgart 
 > > is absent.
 > Looks like the author forgot to set the suspend/resume methods in the
 > structure to the generic ones

   1373 static int __init intel_i830_setup(struct pci_dev *i830_dev)
   1374 {
   1375     intel_i830_private.i830_dev = i830_dev;
   1376     
 ...
   1404     agp_bridge.suspend = agp_generic_suspend;
   1405     agp_bridge.resume = agp_generic_resume;

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
