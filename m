Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTBGLI6>; Fri, 7 Feb 2003 06:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267848AbTBGLI6>; Fri, 7 Feb 2003 06:08:58 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:17158 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267812AbTBGLI5>; Fri, 7 Feb 2003 06:08:57 -0500
Date: Fri, 7 Feb 2003 11:18:36 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030207111836.GE75362@compsoc.man.ac.uk>
References: <200301280121.CAA13798@harpo.it.uu.se> <20030202124235.GA133@elf.ucw.cz> <20030203103254.GA25619@compsoc.man.ac.uk> <20030203154008.GC480@elf.ucw.cz> <20030203202029.GA99614@compsoc.man.ac.uk> <20030203211858.GA3173@elf.ucw.cz> <20030203234307.GA18528@compsoc.man.ac.uk> <20030205213918.GA19615@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205213918.GA19615@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18h6Wi-000PoZ-00*82FelTQO4rk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 10:39:19PM +0100, Pavel Machek wrote:

> I can see set_nmi_pm_callback() in nmi_setup(), but can not see where
> nmi.c's pm_callback is restored in nmi_shutdown().

It's the very first line :

    149         unset_nmi_pm_callback(oprofile_pmdev);

The unset will also restore the nmi_pmdev back.

regards
john
