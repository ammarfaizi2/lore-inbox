Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290719AbSBFSL3>; Wed, 6 Feb 2002 13:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290720AbSBFSLU>; Wed, 6 Feb 2002 13:11:20 -0500
Received: from ns.suse.de ([213.95.15.193]:24594 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290719AbSBFSLK>;
	Wed, 6 Feb 2002 13:11:10 -0500
Date: Wed, 6 Feb 2002 19:11:08 +0100
From: Dave Jones <davej@suse.de>
To: Brent Cook <busterb@mail.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for duplicate /proc entries
Message-ID: <20020206191108.A11277@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Brent Cook <busterb@mail.utexas.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020205213544.J3054-100000@ozma.union.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020205213544.J3054-100000@ozma.union.utexas.edu>; from busterb@mail.utexas.edu on Tue, Feb 05, 2002 at 09:52:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 09:52:55PM -0600, Brent Cook wrote:

 >  I think that I have found a problem with proc_dir_entry(). It seems to
 > allow multiple /proc entries to be created with the same name, without
 > returning a NULL pointer. I asked the folks on #kernelnewbies, and they
 > said that perhaps this is a feature. In either case, I believe that the
 > following patch fixes the issue by checking if a proc entry already exists
 > before creating it. This mirrors the behavior of remove_proc_entry, which
 > checks for the presense of a proc entry before deleting it.

 The only instance I've seen of this happen is the acpi code.
 Whilst the patch is good in the sense that it allows things like
 /proc/acpi/button to become usable, the correct fix would be
 to fix ACPI.

 Maybe printk'ing a "tried to create duplicate xxx proc entry"
 would be useful, so we at least don't paper over problems and
 make them harder to find later.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
