Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131704AbRAHVUR>; Mon, 8 Jan 2001 16:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAHVUH>; Mon, 8 Jan 2001 16:20:07 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:60685 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130497AbRAHVTy>; Mon, 8 Jan 2001 16:19:54 -0500
Date: Mon, 8 Jan 2001 22:15:44 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Brian Macy <bmacy@macykids.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 APM w/ Compaq 16xx laptop...
Message-ID: <20010108221544.Z3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <978926262.3a593ab671347@www.sunshinecomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <978926262.3a593ab671347@www.sunshinecomputing.com>; from bmacy@macykids.net on Sun, Jan 07, 2001 at 07:57:42PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 07:57:42PM -0800, Brian Macy wrote:
> Anyone get this working? If so please tell me the version of you APM utilities
> and what Power Management options you have on in the kernel.
> 
> Ever since I started trying 2.3.x, as soon as the box gets a change in it's
> power status (even just an update of the % battery) Linux locks solid. It's 100%
> repeatable.

Sounds like the kernel is using ACPI reserved memory, so the first ACPI
event corrupts kernel memory and the kernel locks up.

I've seen similar problems with an IBM ThinkPad 600X, but it was fixed
somewhere in 2.4.0-pre12-test7. Try linux-2.4.0, if that doesn't work,
boot the kernel with "mem=1MB-less-than-the-machine-actually-has", so
for a 128MB machine, try "mem=127M".


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
