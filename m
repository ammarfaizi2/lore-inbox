Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272785AbRIRIW2>; Tue, 18 Sep 2001 04:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272795AbRIRIWS>; Tue, 18 Sep 2001 04:22:18 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:4112 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272785AbRIRIWJ>; Tue, 18 Sep 2001 04:22:09 -0400
Date: Tue, 18 Sep 2001 02:39:42 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alex Stewart <alex@foogod.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
Message-ID: <20010918023942.A28179@emma1.emma.line.org>
Mail-Followup-To: Alex Stewart <alex@foogod.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E15ixGu-0006ym-00@the-village.bc.nu> <3BA69421.6020304@foogod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BA69421.6020304@foogod.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Alex Stewart wrote:

> Please note that there is a reason why the "D" state exists, and it is 
> because there are certain times when interrupting a process can have 
> significant consequences on the integrity of the entire filesystem (or 
> other global resource) and must not be allowed for consistency.  As it 

Well, you cannot tell your local power plant "you must not fail this
very moment" either. Of course, data will be lost when a process is
killed from "D" state, but if the admin can tell the data will be lost
either way, ... 

Anyways, I'm going to try the forced umount patch real soon now.

> happens, most of the conditions which cause processes to get "stuck" in 
> disk-wait state (usually because of hardware issues) happen to be 
> exactly the places where it's most difficult to work around this (at 
> least for physically-backed filesystems, less so for NFS et al).

Well, with journals, phase trees/soft updates (hint!) that's less of an
issue.

> Well, yes and no.  It's not _CPU_ load, but the stuck processes can 
> consume other limited resources (memory, file descriptors, etc) to the 
> point that the system is unable to function properly if enough of them 
> accumulate.  I have also had this happen.

You were faster than me with this post ;) With unpatched 2.2, I once
had a machine stuck with an exhausted process table.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
