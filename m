Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314300AbSD0Rra>; Sat, 27 Apr 2002 13:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314303AbSD0Rra>; Sat, 27 Apr 2002 13:47:30 -0400
Received: from ns.suse.de ([213.95.15.193]:58886 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314300AbSD0Rr3>;
	Sat, 27 Apr 2002 13:47:29 -0400
Date: Sat, 27 Apr 2002 19:47:28 +0200
From: Dave Jones <davej@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.10-dj1 compilation failure
Message-ID: <20020427194728.Q14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Christoph Lameter <christoph@lameter.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020427192459.P14743@suse.de> <Pine.LNX.4.44.0204271033010.5612-100000@k2-400.lameter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 10:35:55AM -0700, Christoph Lameter wrote:
 > That stuff might be useful in a CVS or BK() source code archive.
 > What is the purpose of releasing a kernel tarball that does not compile?
 > Kernel tarball are there to be compiled and tried out ....

Because we've gone ~7 full point releases with no updates to the 
error handling of some drivers. Whilst it seems some maintainers are
waiting until the block layer and scsi midlayer frobbing settle down,
running these drivers without /any/ error handling is a disaster
waiting to happen.

Experiments with new filesystem features is going to be tricky to debug
if the scsi drivers are untrustable.

If the maintainers want to continue to wait for 2.5 to settle down,
this at least points those interested in getting their hands dirty
and fix the problem themselves to the parts that need work.

I debated adding this as a CONFIG_DEBUG_BROKEN_SCSI_DRIVERS or similar
when Christoph first sent me the patch.  Given how many reports of
"xxx being broken" I've had, I'm tempted to do that for -dj2.

    Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
