Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTDHQR6 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTDHQR6 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:17:58 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7428 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261863AbTDHQR5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:17:57 -0400
Date: Tue, 8 Apr 2003 18:30:54 +0200
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67 kernel BUG at fs/buffer.c:2538
Message-ID: <20030408163054.GA568@hh.idb.hist.no>
References: <1049815653.32665.1135.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049815653.32665.1135.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 09:27:33AM -0600, Steven Cole wrote:
> This may be a case of:
> 
> "It hurts when I do this:"
> "Then don't do that!"
> 
> I started the latest security updated package of samba with
> kernel 2.5.67, but I had forgotten to set CONFIG_SMB_FS.
> The box became unresponsive, and then locked hard. Didn't respond
> to pings, etc.  So I had to alt-sysrq-b. Now, samba is broken somehow, 
> ERROR: Samba cannot create a SAM SID.
> so I can't presently retest with SMB_FS=y and 2.5.67 or with
> the vendor kernel (2.4.21-0.13mdk). 

I tried starting samba on 2.5.66-mm3, and it died the same way,
even though I had smbfs compiled in.  I guess smbfs in 2.5 is a bit
shaky, at least in some configurations.  Do you too have
preempt?

 Unfortunately I had not yet 
> tested the new security updated packages for samba with the vendor kernel.
> 
> However dumb it was to start samba without SMB_FS enabled,
> the box shouldn't die like this.

Definitely not.  Samba software is supposed to simply fail when
the kernel don't support it.
 
Helge Hafting

