Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbTCCM4H>; Mon, 3 Mar 2003 07:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTCCM4H>; Mon, 3 Mar 2003 07:56:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55962
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264830AbTCCM4G>; Mon, 3 Mar 2003 07:56:06 -0500
Subject: Re: S4bios support for 2.5.63
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger Luethi <rl@hellgate.ch>
Cc: bert hubert <ahu@ds9a.nl>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030303003940.GA13036@k3.hellgate.ch>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
	 <20030303003940.GA13036@k3.hellgate.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046700547.5890.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 14:09:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 00:39, Roger Luethi wrote:
> The only thing that came up at the time was a suggestion to replace BUG_ON
> with while (which I didn't try because I'd like to keep my data).

That isnt far off what you want. IDE has proper command queuing functionality and
providing you are suspending in a sleeping context you can do what you are trying
to do through the IDE layer politely. Take a look at how the various ide taskfile
ioctls issue commands.

