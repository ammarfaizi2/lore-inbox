Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVC2LbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVC2LbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVC2LbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:31:14 -0500
Received: from upco.es ([130.206.70.227]:20408 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262199AbVC2Laq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:30:46 -0500
Date: Tue, 29 Mar 2005 13:30:42 +0200
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux-input@atrey.karlin.mff.cuni.cz,
       Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: ALPS touchpad woes with 2.6.12rc1 and rc1-mm3
Message-ID: <20050329113042.GA19324@pern.dea.icai.upco.es>
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-input@atrey.karlin.mff.cuni.cz,
	Vojtech Pavlik <vojtech@suse.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   In the kernels 2.6.12-rc1 and 2.6.12-rc1-mm3 my ALPS touchpad is not 
   recognized by the Xorg driver. The strange thing is that in dmesg ALPS is
   detected, but then the Xorg driver tell strange things... 
   
   In dmesg:
   [4294673.596000]   Enabling hardware tapping
   [4294673.656000] input: PS/2 Mouse on isa0060/serio1
   [4294673.659000] input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
   
   In Xorg.0.log: (conf file is: 
   http://www.dea.icai.upco.es/romano/linux/xorg.conf.txt ) 
   
   
   (**) |-->Input Device "alps"
   (**) |-->Input Device "mice"
   [..]
   (II) LoadModule: "synaptics"
   (II) Loading /usr/X11R6/lib/modules/input/synaptics_drv.o
   (II) Module synaptics: vendor="The XFree86 Project"
        compiled for 4.2.0, module version = 1.0.0
        Module class: XFree86 XInput Driver
        ABI class: XFree86 XInput driver, version 0.3
   
   but after this: 
   
   (II) Synaptics touchpad driver version 0.14.0
   (**) Option "Device" "/dev/input/event1"
   
   (EE) alps no synaptics touchpad detected and no repeater device
   (EE) alps Unable to query/initialize Synaptics hardware.
   (EE) PreInit failed for input device "alps"

   It worked ok in 2.6.11.
   
   All the configuration, dmesg, lsmod, Xorg.0.log is etc is here for -rc1: 
   
   http://www.dea.icai.upco.es/romano/linux/config-2.6.12-rc1/laptop-config.html

   And here for -rc1-mm3: 

   http://www.dea.icai.upco.es/romano/linux/config-2.6.12-rc1/laptop-config.html

   Perfectly working similar data is in: 
   
   http://www.dea.icai.upco.es/romano/linux/config-2.6.11-rg/laptop-config.html


          Romano 
   
   

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
