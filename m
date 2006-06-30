Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWF3Nx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWF3Nx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWF3Nx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:53:59 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:33972 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932699AbWF3Nx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:53:58 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: readahead - access beyond end of device; then hang (2.6.17-git14)
Date: Fri, 30 Jun 2006 15:53:52 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301553.52903.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, X-windows became sluggish, but without any
obvious reason.  Then I noticed that the main
network interface wasn't configured, and ran dhclient
to set it up.  At that point (hda2 mounted on /),
I got the following messages and the machine hung.
Ideas anyone?

Duncan.

[28029.821328] attempt to access beyond end of device
[28029.835721] hda2: rw=0, want=723745656, limit=28772415
[28029.851370] attempt to access beyond end of device
[28029.865765] hda2: rw=0, want=3415755704, limit=28772415
[28029.881697] attempt to access beyond end of device
[28029.896078] hda2: rw=0, want=1402680224, limit=28772415
[28029.912001] attempt to access beyond end of device
[28029.926393] hda2: rw=0, want=723745656, limit=28772415
[28029.942202] attempt to access beyond end of device
[28029.956597] hda2: rw=0, want=2073054136, limit=28772415
[28029.972741] attempt to access beyond end of device
[28029.987115] hda2: rw=0, want=2603852672, limit=28772415
[28030.003021] attempt to access beyond end of device
[28030.017399] hda2: rw=0, want=595292248, limit=28772415
[28030.033045] attempt to access beyond end of device
[28030.047425] hda2: rw=0, want=273396528, limit=28772415
[28030.063058] attempt to access beyond end of device
[28030.077450] hda2: rw=0, want=1404250920, limit=28772415
[28030.093346] attempt to access beyond end of device
[28030.107735] hda2: rw=0, want=723745656, limit=28772415
[28030.123368] attempt to access beyond end of device
[28030.137762] hda2: rw=0, want=2474658744, limit=28772415
[28030.153668] attempt to access beyond end of device
[28030.168046] hda2: rw=0, want=1884494720, limit=28772415
[28030.183953] attempt to access beyond end of device
[28030.198333] hda2: rw=0, want=3005948800, limit=28772415
[28030.214241] attempt to access beyond end of device
[28030.228617] hda2: rw=0, want=461084752, limit=28772415
[28030.244264] attempt to access beyond end of device
[28030.258644] hda2: rw=0, want=1402680160, limit=28772415
[28030.274537] attempt to access beyond end of device
[28030.288931] hda2: rw=0, want=723745656, limit=28772415
[28030.304578] attempt to access beyond end of device
[28030.318956] hda2: rw=0, want=1266699192, limit=28772415
[28030.334642] attempt to access beyond end of device
[28030.349031] hda2: rw=0, want=2603821960, limit=28772415
[28030.364720] attempt to access beyond end of device
[28030.379108] hda2: rw=0, want=595292248, limit=28772415
[28030.394539] attempt to access beyond end of device
[28030.408926] hda2: rw=0, want=810267440, limit=28772415
[28030.424357] attempt to access beyond end of device
[28030.438744] hda2: rw=0, want=723745656, limit=28772415
[28030.455005] attempt to access beyond end of device
[28030.469393] hda2: rw=0, want=723745656, limit=28772415
[28030.484822] Reducing readahead size to 32K
