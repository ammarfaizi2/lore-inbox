Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130613AbQLELD4>; Tue, 5 Dec 2000 06:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130807AbQLELDr>; Tue, 5 Dec 2000 06:03:47 -0500
Received: from viva.uti.hu ([213.163.24.26]:25867 "HELO viva.uti.hu")
	by vger.kernel.org with SMTP id <S130613AbQLELDd>;
	Tue, 5 Dec 2000 06:03:33 -0500
Date: Tue, 5 Dec 2000 11:33:03 +0100
From: G?bor L?n?rt <lgb@viva.uti.hu>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any good reason why these is so much memory "reserved"?
Message-ID: <20001205113303.A18808@viva.uti.hu>
In-Reply-To: <200012051018.CAA01847@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012051018.CAA01847@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Dec 05, 2000 at 02:18:59AM -0800
X-Operating-System: viva Linux 2.2.16 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 02:18:59AM -0800, Adam J. Richter wrote:
> 	Recently, I have had occasion to build a system on a floppy
> for a 4MB machine that we use as a router.  In the past, the kernels

I've played with this too. You can't use ramdisk easily on such a system.
We used root filesystem on floppy without any ramdisk ability and the
memory was enough to boot and route packages. Maybe you can try something
on-the-fly decompressed filesystem to reduce the needed size on the floppy.
I used romfs on floppy because of the small size of fs driver code. And I
don't need to build IDE, SCSI and other modules only floppy, and of course
some network code to do the simple routing we used. The kernel was statically
linked to avoid to having kernel module loading utilities. Though it was
2.2.x kernel.
-- 
 ---[ Gábor Lénárt ]----[ Vivendi Telecom Hungary ]---[ lgb@supervisor.hu ]---
 U have 8 bit computer or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]--------> LGB <-------[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
