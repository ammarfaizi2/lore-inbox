Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273917AbRIXN55>; Mon, 24 Sep 2001 09:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273912AbRIXN5t>; Mon, 24 Sep 2001 09:57:49 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33297 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273911AbRIXN5l>; Mon, 24 Sep 2001 09:57:41 -0400
Date: Mon, 24 Sep 2001 15:58:04 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mingo@redhat.com
Subject: 2.4.10-pre15 -> final breaks IOAPIC on UP?
Message-ID: <20010924155804.A5540@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	mingo@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently reported difficulties with several 2.4.9-ac and
2.4.10-vanilla versions that froze solid when exiting an X11 display and
returning to text-mode display (XFree 4.1.0, Diamond V550 (Riva TNT)
with nv driver), not even SysRq would help.

After some research (took several hours worth of trail & error), I think
I found the culprit, but first look at the figures. All share the same
configuration which I can provide on request, which includes IOAPIC
support on Uniprocessor machines (Duron/700 in Gigabyte 7ZX-R here):

2.4.9: ok
2.4.10-pre7: ok
2.4.10-pre12: ok
2.4.10-pre14: ok
2.4.10-pre15: ok
2.4.10-final: broken, freezes
2.4.10-final: ok if compiled without IOAPIC support on UP.

So, I believe that any IOAPIC related change between 2.4.10-pre15 and
2.4.10-final breaks my X11 here.

Any comments?

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
